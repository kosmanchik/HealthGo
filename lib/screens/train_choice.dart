import 'package:flutter/material.dart';
import 'package:health_go/screens/train/exercise_screen.dart';
import 'package:health_go/screens/train/start_train_screen.dart';
import 'package:health_go/supportive_widgets/button.dart';
import 'package:health_go/supportive_widgets/image_section.dart';
import 'package:health_go/supportive_widgets/text_section.dart';

class TrainChooseScreen extends StatelessWidget {
  const TrainChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFF3EDF7)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 18,
          children: [
            TextSection("Выбор плана тренировки"),

            Button(Size(353.0, 40.0), "Готовый план тренировок", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StartTrainScreen())
              );
            }, Color(0xFFECE6F0)),
            Button(Size(353.0, 40.0), "Создание индивидуального плана", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StartTrainScreen())
              );
            }, Color(0xFFECE6F0)),
            Button(Size(353.0, 40.0), "Выбор отдельных упражнений", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StartTrainScreen())
              );
            }, Color(0xFFECE6F0))
          ],
        )
      ),
    );
  }
}