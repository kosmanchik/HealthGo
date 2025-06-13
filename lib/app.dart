import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/start_screen.dart';

class MainApp extends StatelessWidget //класс приложения
{
  const MainApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(412, 815),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: "HealthGo",
          theme: ThemeData(scaffoldBackgroundColor: Color(0xFFFFFFFF)),
          home: StartScreen()
        );
      },
    );     
  }
}