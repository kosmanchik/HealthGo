import 'package:flutter/material.dart';
import 'package:health_go/screens/main_screen.dart';
import 'package:health_go/screens/train_choice.dart';
import 'package:health_go/supportive_widgets/button.dart';
import 'package:health_go/supportive_widgets/text_section.dart';
import '../user/preferences.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFF3EDF7)),
      body: Center( //центрирование кнопки
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 18,
          children: [
            TextSection("Какой результат Вы хотите получить?"),
            Button(Size(353.0, 40.0), "Снизить вес", () async {
              UserPreferences.SetIfRegistrated(true); //если пользователь нажал на кнопку, то считаем его локально зарегистрированным
              UserPreferences.SetGoal("Похудеть"); //запоминаем цель пользователя
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen())
                );
              }, Color(0xFFECE6F0)
            ), 
            Button(Size(353.0, 40.0), "Набрать вес", () async {
              UserPreferences.SetIfRegistrated(true);
              UserPreferences.SetGoal("Набрать вес");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen())
                );
              }, Color(0xFFECE6F0)
            ),

            Button(Size(353.0, 40.0), "Поддержать вес", () async {
              UserPreferences.SetIfRegistrated(true);
              UserPreferences.SetGoal("Поддержать вес");
              Navigator.pushReplacement( //Замена данного экрана в стэке на следующий
                context,
                MaterialPageRoute(builder: (context) => MainScreen())
                );
              }, Color(0xFFECE6F0)
            ),
          ]
        ),
      ) 
      
    );
  }
}