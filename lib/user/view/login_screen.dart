import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/component/custom_text_form_field.dart';
import 'package:flutter_inf_app/common/component/layout/default_layout.dart';
import 'package:flutter_inf_app/common/const/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
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
