import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_go/supportive_widgets/button.dart';
import 'package:health_go/supportive_widgets/input_textbox.dart';
import 'package:health_go/supportive_widgets/registration_text.dart';

class RegistrationScreen extends StatelessWidget{
  const RegistrationScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFDED8E0),
          boxShadow: [ 
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 6,
              blurRadius: 12,
              offset: Offset(0, 8),
            )]
          ),        
        height: 510,
        width: 306,
        margin: EdgeInsets.only(top: 86, left: 48),
        child: Column(
          children: [
            Container(
              height: 53,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFFFFFFF),
              ),
              margin: const EdgeInsets.only(top: 14),
              child: Center(child: Text("Регистрация", style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ))
              ),
            ),

            SizedBox(height: 11),

            RegistrationText("Введите свои данные", 187, 30),

            InputTextBox("Ваше имя", 220, 40),
            SizedBox(height: 20),
            InputTextBox("Ваш возраст", 220, 40),
            SizedBox(height: 35),

            RegistrationText("Введите электронную почту", 251, 30),

            InputTextBox("Ivan@gmail.com", 262, 40),
            SizedBox(height: 20),
            InputTextBox("Пароль", 262, 40),

            SizedBox(height: 79),
            Container( 
              margin: EdgeInsets.only(left: 170),
              child:
                Button.withCustomTextColor(Size(116, 32), "Продолжить", () =>
                  showDialog(
                    context: context, 
                    builder: (context) => AlertDialog(
                      title: Text("Сохранить данные?"),
                      actions: [
                        TextButton(
                          onPressed: () => (),
                          child: Text("Нет")),
                        TextButton(
                          onPressed: () {},
                          child: Text("Да")
                        )
                      ],
                    )
                  ),
                  Color(0xFF1E1E1E), Color(0xFFF5F5F5)
                ),
            )
          ],
        ),
      ),
    );
  }
}