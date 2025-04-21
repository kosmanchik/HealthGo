import 'package:flutter/material.dart';
import 'package:health_go/screens/goal_screen.dart';
import 'package:health_go/screens/train_choice.dart';
import 'package:health_go/supportive_widgets/image_section.dart';
import '../supportive_widgets/button_icon.dart';
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
          ButtonIcon(Icon(Icons.double_arrow_outlined), Size(116.0, 56.0), "Зайти как гость", () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                if (!_isRegitrated) {
                  return GoalScreen();
                }
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