import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_inf_app/common/const/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  //accesstoken을 스토리지에서 꺼내오기 위한 변수
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });
  //1) 요청을 보낼때(보내지기전에)
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQUEST] ${options.method} ${options.uri}');

    // restaurant_repository.dart에서 accessToken이 true일때만 실행
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      });
    }

    return super
        .onRequest(options, handler); // handler를 가지고 에러를 생성할지 요청을 보낼지 결정
  }

  //2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RESPONSE] ${response.statusCode} ${response.requestOptions.uri}');
    // print('[RESPONSE] ${response.data}');
    return super.onResponse(response, handler);
  }

  //3) 에러가 발생했을때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        '[ERROR] ${err.requestOptions.method} ${err.requestOptions.uri} ${err.message}');
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null) {
      // error를 발생시키는 방법은 handler.reject를 사용
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    // token을 재발급 받으려고 하지 않았는데 401에러가 발생했다면
    // 즉, token이 만료되었다면 refreshToken을 이용해서 accessToken을 재발급 받아서 재전송
    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();
      // refreshToken을 이용해서 accessToken을 재발급 받기
      try {
        final resp = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $refreshToken'},
          ),
        );

        final accessToken = resp.data['accessToken'];
        // accessToken을 원래 error가 났던 요청헤더에 추가
        final options = err.requestOptions;
        options.headers
            .addAll({HttpHeaders.authorizationHeader: 'Bearer $accessToken'});
        // SecureStorage에 새로운 aceessToken을 저장
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        // 새로운 accessToken을 가지고 다시 요청을 보내기
        final response = await dio.fetch(options);
        // 새로운 요청에서 정상응답이 왔다면 정상응답을 반환
        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.reject(e);
      }
    }
    return super.onError(err, handler);
  }
}
