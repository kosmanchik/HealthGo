import 'package:flutter/widgets.dart';
import 'package:health_go/screens/Train/exercise_screen.dart';
import 'package:health_go/supportive_widgets/image_section.dart';
import 'package:pair/pair.dart';

class Trains { //Класс тренировок, добавляем сюда все заготовленные тренировки в виде массива упражнений в нужном порядке

  static final Pair<List<Widget>, bool> classicTrain = Pair<List<Widget>, bool>([
    ExerciseScreen(ImageSection("assets/images/bridge_exercise.png"), 90),
    ExerciseScreen(ImageSection("assets/images/squats_exercise.png"), 120),
    ExerciseScreen(ImageSection("assets/images/dumbell_squats_exercise.png"), 60),
    ExerciseScreen(ImageSection("assets/images/back_exercise.png"), 90),
    ExerciseScreen(ImageSection("assets/images/lunges_exercise.png"), 90)
  ], false);
}