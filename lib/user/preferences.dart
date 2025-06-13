import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences { //простые данные о пользователе, которые сохраняются локально
  static SharedPreferences? _preferences;
  static final String _registratedKey = 'registred';
  static final String _goalKey = 'goal';
  static final String _registratedFirebaseKey = 'firebase-doc';
  
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future SetIfRegistrated(bool ifRegistrated) async => await _preferences?.setBool(_registratedKey, ifRegistrated);
  static bool? GetIsGoalSet() =>  _preferences?.getBool(_registratedKey);

  static Future SetFirebaseRegistrated(bool registred) async => await _preferences?.setBool(_registratedFirebaseKey, registred);
  static bool? GetFirebaseRegistrated() => _preferences?.getBool(_registratedFirebaseKey);

  static Future SetGoal(String goal) async => await _preferences?.setString(_goalKey, goal);
  static String? GetGoal() => _preferences?.getString(_goalKey);
}