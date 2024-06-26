import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/component/custom_text_form_field.dart';
import 'package:flutter_inf_app/common/component/layout/default_layout.dart';
import 'package:flutter_inf_app/common/const/colors.dart';
import 'package:flutter_inf_app/common/const/data.dart';
import 'package:flutter_inf_app/common/dio/dio.dart';
import 'package:flutter_inf_app/common/secure_storage/secure_storage.dart';
import 'package:flutter_inf_app/common/view/root_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String userName = '';
  String password = '';

//stateful widget이기 때문에 WidgetRef가 없어도 됨!
  @override
  Widget build(BuildContext context) {
    final dio = ref.watch(dioProvider);

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
                  onChanged: (String value) {
                    userName = value;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요.',
                  obcureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  onPressed: () async {
                    // id:pw
                    String rawString = '$userName:$password';
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
                    // 함수안에서만 사용되는거니까 사용되기 직전에 선언함.
                    final storage = ref.watch(secureStorageProvider);
                    await storage.write(
                        key: REFRESH_TOKEN_KEY,
                        value: resp.data['refreshToken']);
                    await storage.write(
                        key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RootTab(),
                      ),
                    );
                  },
                  child: const Text(
                    '로그인',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {},
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
