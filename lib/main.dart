import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_go/firebase_options.dart';
import '../user/preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app.dart';

Future main() async { //точка входа в приложение
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserPreferences.init(); //инициализируем данные о пользователе
  runApp(const MainApp());
}  