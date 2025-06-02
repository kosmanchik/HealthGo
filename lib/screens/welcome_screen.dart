import 'package:flutter/material.dart';
import 'package:health_go/screens/goal_screen.dart';
import 'package:health_go/screens/main_screen.dart';
import 'package:health_go/screens/registration_screen.dart';
import 'package:health_go/screens/train_choice.dart';
import 'package:health_go/supportive_widgets/image_section.dart';
import '../supportive_widgets/button_icon.dart';
import '../user/preferences.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget{
  final bool _isGoalSet = UserPreferences.GetIsGoalSet() ?? false; //либо мы знаем что пользователь зарегистрирован и сохраняли это => true, либо нет => false

  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageSection("assets/images/running_girl.png"),

          ButtonIcon(Icon(Icons.account_circle_outlined), Size(195.0, 45.0), "Регистрация / Вход", () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (contex) => RegistrationScreen()));
          }, Color(0xFF6750A4), Color(0xFFFFFFFF)),
          SizedBox(height: 9),
          ButtonIcon.withStandardColor(Icon(Icons.double_arrow_outlined), Size(165.0, 36.0), "Зайти как гость", () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                if (!_isGoalSet) {
                  return GoalScreen();
                }
                UserPreferences.SetFirebaseRegistrated(false);
                return TrainChooseScreen();
                }
              ), 
              (route) => false); //Очищение стэка экранов (незачем хранить экраны регистрации и старта, когда пользователь уже вошел)
          })
        ],
      ) 
    );
  }
}