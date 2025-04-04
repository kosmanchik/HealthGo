import 'package:flutter/material.dart';
import '../user/preferences.dart';
import 'app.dart';

void main() async { //точка входа в приложение
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences.init(); //инициализируем данные о пользователе
  runApp(const MainApp());
}  