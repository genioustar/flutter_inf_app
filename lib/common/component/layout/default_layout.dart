import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget widget;
  // appBar 에 titlle을 넣을 수 있도록 추가
  final String? title;
  // bottomNavigationBar 선택적으로 넣을 수 있도록 추가
  final Widget? bottomNavigationBar;
  const DefaultLayout({
    super.key,
    required this.widget,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: widget,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title!,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      );
    }
  }
}
