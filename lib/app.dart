import 'package:flutter/material.dart';
import 'screens/start_screen.dart';

class MainApp extends StatelessWidget //класс приложения
{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HealthGo",
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFFFFFFF)),
      home: StartScreen()
    );
  }
}