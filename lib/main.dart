import 'package:flutter/material.dart';
import 'package:light_mart/modules/on_boarding/on_boarding_screen.dart';
import 'package:light_mart/shared/styles/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme:lightTheme,
      darkTheme:darkTheme,

      home: OnBoardingScreen(),
    );
  }
}

