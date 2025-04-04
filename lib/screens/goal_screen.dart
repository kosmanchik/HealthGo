import 'package:flutter/material.dart';
import '../supportive_widgets/button.dart';
import '../user/preferences.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( //центрирование кнопки
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Button(null, "Похудеть", () async {
              UserPreferences.SetIfRegistrated(true); //если пользователь нажал на кнопку, то считаем его локально зарегистрированным
              UserPreferences.SetGoal("Похудеть"); //запоминаем цель пользователя
              }
            ), 
            Button(null, "Набрать вес", () async {
              UserPreferences.SetIfRegistrated(true);
              UserPreferences.SetGoal("Набрать вес");
              }
            ),
            Button(null, "Поддержать вес", () async {
              UserPreferences.SetIfRegistrated(true);
              UserPreferences.SetGoal("Поддержать вес");
              }
            ),
          ]
        ),
      ) 
      
    );
  }
}