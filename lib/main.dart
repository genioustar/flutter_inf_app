import 'package:flutter/material.dart';
import 'package:flutter_inf_app/common/component/custom_text_form_field.dart';

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
      ),
      home: const Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CustomTextFormField()],
        ),
      ),
    );
  }
}
