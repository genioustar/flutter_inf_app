import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/component/layout/default_layout.dart';
import 'package:flutter_inf_app/common/const/colors.dart';
import 'package:flutter_inf_app/common/const/data.dart';
import 'package:flutter_inf_app/common/secure_storage/secure_storage.dart';
import 'package:flutter_inf_app/common/view/root_tab.dart';
import 'package:flutter_inf_app/user/view/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 앱에 처음 진입하면 다양한 정보를 로딩하고 어디로 분기해줄지 판단하는 화면
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // deleteToken();
    checkToken();
  }

  void deleteToken() async {
    //함수 내부에서만 사용됨으로 사용직전에 선언하기!
    // ref를 어떻게 쓸수있음?? stateful widget이기 때문에 사용가능
    final storage = ref.read(secureStorageProvider);
    await storage.deleteAll();
  }

  void checkToken() async {
    final storage = ref.read(secureStorageProvider);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    print('refreshToken : $refreshToken accessToken : $accessToken');

    final dio = Dio();

    try {
      final resp = await dio.post(
        'http://$ip/auth/token',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $refreshToken'},
        ),
      );

      print(resp.statusCode);

      await storage.write(
        key: ACCESS_TOKEN_KEY,
        value: resp.data['accessToken'],
      );

      if (!mounted) return; // Check if the widget is still in the widget tree

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const RootTab(),
        ),
        (route) => false,
      );
    } catch (e) {
      print(e);

      if (!mounted) return; // Check if the widget is still in the widget tree

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      widget: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
