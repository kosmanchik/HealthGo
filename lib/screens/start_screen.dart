import 'package:flutter/material.dart';
import 'package:health_go/screens/welcome_screen.dart';
import '../supportive_widgets/image_section.dart';
import '../supportive_widgets/button_icon.dart';

class StartScreen extends StatelessWidget //виджет стартового экрана
{
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column( //колона с изображением и кнопкой
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 97,
        children: [
          ImageSection("assets/images/start_screen_man.png"),         
          ButtonIcon.withStandardColor(Icon(Icons.emoji_emotions_outlined), Size(116.0, 56.0), "СТАРТ", () {
            //функция перехода на страницу регистрации
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen())
            );
          })
        ],
      )
    );
  }
}