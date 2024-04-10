import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget widget;
  const DefaultLayout({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget,
    );
  }
}
