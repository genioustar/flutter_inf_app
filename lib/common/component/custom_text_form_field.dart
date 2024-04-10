import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obcureText;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;

  CustomTextFormField({
    super.key,
    this.hintText,
    this.errorText,
    this.obcureText = false,
    this.autoFocus = false,
    this.onChanged,
  });

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: INPUT_BORDER_COLOR,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      // 입력값 숨기기(비밀번호 입력시)
      obscureText: obcureText,
      // 화면에 오는 순간 자동으로 포커스
      autofocus: autoFocus,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 16,
        ),
        fillColor: INPUT_BG_COLOR,
        // 이값이 있어야지 fillColor가 먹음
        filled: true,
        // 선택 안됐을때 테두리 색상
        border: border,
        enabledBorder: border,
        // 선택 됐을때 테두리 색상
        focusedBorder: border.copyWith(
          // 기존의 border 속성은 모두 유지한체 색상만 변경
          borderSide: border.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
