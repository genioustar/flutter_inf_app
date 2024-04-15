import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'NotoSansKR',
      ),
      home: const SplashScreen(),
    );
  }
}
