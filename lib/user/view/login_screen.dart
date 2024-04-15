import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/component/custom_text_form_field.dart';
import 'package:flutter_inf_app/common/component/layout/default_layout.dart';
import 'package:flutter_inf_app/common/const/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    // localhost for android emulator and ios simulator
    const emulatorIp = '10.0.2.2:8099';
    const simulatorIp = '127.0.0.1:8099';

    // 모바일 디바이스에 따라서 다른 ip를 사용
    final ip = Platform.isIOS ? simulatorIp : emulatorIp;

    return DefaultLayout(
      widget: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const _Title(),
                const SizedBox(height: 8),
                const _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요.',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요.',
                  obcureText: true,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  onPressed: () async {
                    // id:pw
                    const rawString = 'test@gmail.com:testtest';
                    // utf8, base64 인코딩
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);
                    final token = stringToBase64.encode(rawString);
                    final resp = await dio.post(
                      'http://$ip/auth/login',
                      options: Options(
                        headers: {
                          HttpHeaders.authorizationHeader: 'Basic $token'
                        },
                      ),
                    );
                    print(resp.data);
                  },
                  child: const Text(
                    '로그인',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    const refreshToken = '31231231234555';
                    final resp = await dio.post(
                      'http://$ip/auth/token',
                      options: Options(
                        headers: {
                          HttpHeaders.authorizationHeader:
                              'Bearer $refreshToken'
                        },
                      ),
                    );
                    print(resp.data);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: PRIMARY_COLOR,
                  ),
                  child: const Text('회원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요! \n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
