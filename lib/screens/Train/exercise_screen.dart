import 'package:flutter/material.dart';
import 'package:health_go/screens/train_choice.dart';
import 'package:health_go/supportive_widgets/image_section.dart';
import 'package:health_go/supportive_widgets/button.dart';
import 'package:health_go/supportive_widgets/time_container.dart';
import 'dart:async';

class ExerciseScreen extends StatefulWidget{
  
  final ImageSection _exerciseImage;
  final int _secondsTime;

  const ExerciseScreen(this._exerciseImage, this._secondsTime, {super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late int _remainingSeconds;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget._secondsTime;
    StartTimer();
  }

  void Destroy() {
    _timer.cancel();
    if (Navigator.canPop(context)){
      Navigator.pop(context);
    }
  }

  void StartTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_remainingSeconds == 0) { //добавить звук окончания таймера
          setState(() {
            Destroy();
          });
        } else {
          setState(() {
            _remainingSeconds--;
          });
        }
      },
    );
  }

  String GetMinutes(int seconds) {
    int minutes = (seconds ~/ 60);
    return minutes.toString();
  }
  
  String GetSeconds(int seconds) {
    int secondsInCurrentMinute = seconds % 60;
    return secondsInCurrentMinute.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFF3EDF7), automaticallyImplyLeading: false),

      body: Center( child: Column (
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          widget._exerciseImage, //изображение упражнения

          SizedBox(height: 16),

          Container( //внешний контейнер для минут и секунд
            height: 105,
            width: 235,
            decoration: BoxDecoration(
              color: Color(0xFFECE6F0),
              borderRadius: BorderRadius.circular(28)
            ),
            child: 
              Row(children: [
                TimeContainer(GetMinutes(_remainingSeconds), Color(0xFFE7E7E7), EdgeInsets.only(left: 24, right: 0, bottom: 23, top: 5)),

                Container( //разделитель минут и секунд
                  margin: EdgeInsets.only(bottom: 23),
                  child: Text(":", style: TextStyle(fontSize: 57, fontWeight: FontWeight.w400))
                ),

                TimeContainer(GetSeconds(_remainingSeconds), Color(0xFFE6E0E9), EdgeInsets.only(right: 24, left: 0, bottom: 23, top: 5)),
              ]
            )
          ),

          SizedBox(height: 23),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Button(Size(127, 40), "Пропустить", () => 
                  GetDialog(context, "Пропуск тренировки", "Вы точно хотите пропустить текущее упражнение?", () {
                    Navigator.pop(context, 'OK'); //убираем диалоговое окно и потом уничтожаем экран
                    Destroy();
                  }),
               Color(0xFFFFFFFF)),

              //Останавливаем таймер, перемещаем пользователя на экран выбора тренировок и очищаем стэк с экранами прошедших тренировок
              Button(Size(127, 40), "Завершить", () => 
                GetDialog(context, "Завершение тренировки", "Вы точно хотите завершить тренировку?", () {
                  _timer.cancel();
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (context) => TrainChooseScreen()),
                    (route) => false
                  );
                }),
              Color(0xFFEADDFF)),
            ],
          ),
        ],
      ))
    );
  }

  void GetDialog(BuildContext context, String title, String message, VoidCallback onPressedOK) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, "Отмена"), 
            child: const Text("Отмена")
          ),
          TextButton(
            onPressed: onPressedOK,
            child: const Text('OK'),
          ),
        ],
      )
    );
  }
}