import 'package:flutter/material.dart';
import 'package:health_go/supportive_widgets/image_section.dart';
import '../supportive_widgets/button.dart';

class RegistrationScreen extends StatelessWidget{
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 28,
        children: [
          ImageSection("assets/images/running_girl.png"),
          Button(Icons.double_arrow_outlined, "Зайти как гость", () {})
        ],
      ) 
    );
  }
}