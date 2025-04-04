import 'package:flutter/material.dart';
import 'package:health_go/screens/goal_screen.dart';
import 'package:health_go/screens/start_screen.dart';
import 'package:health_go/supportive_widgets/image_section.dart';
import '../supportive_widgets/button.dart';
import '../user/preferences.dart';

// ignore: must_be_immutable
class RegistrationScreen extends StatelessWidget{
  final bool _isRegitrated = UserPreferences.GetIfRegistrated() ?? false; //либо мы знаем что пользователь зарегистрирован и сохраняли это => true, либо нет => false

  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 28,
        children: [
          ImageSection("assets/images/running_girl.png"),
          Button(Icon(Icons.double_arrow_outlined), "Зайти как гость", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                if (!_isRegitrated) {
                  return GoalScreen();
                }
                return StartScreen(); //Заменить на экран выбора тренировки, когда сделаем его 
              }
              ));
          })
        ],
      ) 
    );
  }
}