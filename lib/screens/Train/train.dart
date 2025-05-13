import 'package:flutter/widgets.dart';
import 'package:health_go/screens/Train/exercise_screen.dart';
import 'package:health_go/supportive_widgets/image_section.dart';

class Trains { //Класс тренировок, добавляем сюда все заготовленные тренировки в виде массива упражнений в нужном порядке

  static final List<Widget> classicTrain = [
    ExerciseScreen(ImageSection("assets/images/bridge_exercise.png"), 90),
    ExerciseScreen(ImageSection("assets/images/squats_exercise.png"), 120),
    ExerciseScreen(ImageSection("assets/images/dumbell_squats_exercise.png"), 60),
    ExerciseScreen(ImageSection("assets/images/back_exercise.png"), 90),
    ExerciseScreen(ImageSection("assets/images/lunges_exercise.png"), 90)
  ];
}