import 'package:flutter/material.dart';
import 'package:health_go/supportive_widgets/text_section.dart';
import '../supportive_widgets/button.dart';

class TrainChooseScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF65558F)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 18,
          children: [
            TextSection("Выбор плана тренировки"),

            Button(null, 353.0, 40.0, "Готовый план тренировок", () {}),
            Button(null, 353.0, 40.0, "Создание индивидуального плана", () {}),
            Button(null, 353.0, 40.0, "Выбор отдельных упражнений", () {})
          ],
        )
      ),
    );
  }
}