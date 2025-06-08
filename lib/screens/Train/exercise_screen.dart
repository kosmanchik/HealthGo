import 'package:flutter/material.dart';
import 'package:health_go/screens/train_choice.dart';
import 'package:health_go/supportive_widgets/image_section.dart';
import 'package:health_go/supportive_widgets/button.dart';
import 'package:health_go/supportive_widgets/time_container.dart';
import 'dart:async';

class ExerciseScreen extends StatefulWidget {
  final ImageSection _exerciseImage;
  final int _secondsTime;
  final String instruction; // Инструкция

  const ExerciseScreen(
    this._exerciseImage,
    this._secondsTime, {
    required this.instruction,
    super.key,
  });

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late int _remainingSeconds;
  Timer? _timer;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget._secondsTime;
    _startTimer();
  }

  void _destroy() {
    _timer?.cancel();
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (!_isPaused) {
        if (_remainingSeconds == 0) {
          _destroy();
        } else {
          setState(() {
            _remainingSeconds--;
          });
        }
      }
    });
  }

  void _pauseTimer() {
    setState(() {
      _isPaused = true;
    });
  }

  void _resumeTimer() {
    setState(() {
      _isPaused = false;
    });
  }

  String _getMinutes(int seconds) => (seconds ~/ 60).toString().padLeft(2, '0');
  String _getSeconds(int seconds) => (seconds % 60).toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF3EDF7),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              // кнопка инструкции
              icon: Icon(Icons.info_outline),
              onPressed: () {
                _pauseTimer();
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text("Инструкция"),
                        content: Text(widget.instruction),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _resumeTimer();
                            },
                            child: Text("Понятно"),
                          ),
                        ],
                      ),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget._exerciseImage,
              SizedBox(height: 16),
              Container(
                height: 105,
                width: 235,
                decoration: BoxDecoration(
                  color: Color(0xFFECE6F0),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  children: [
                    TimeContainer(
                      _getMinutes(_remainingSeconds),
                      Color(0xFFE7E7E7),
                      EdgeInsets.only(left: 24, right: 0, bottom: 23, top: 5),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 23),
                      child: Text(
                        ":",
                        style: TextStyle(
                          fontSize: 57,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TimeContainer(
                      _getSeconds(_remainingSeconds),
                      Color(0xFFE6E0E9),
                      EdgeInsets.only(right: 24, left: 0, bottom: 23, top: 5),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    Size(127, 40),
                    "Пропустить",
                    () => _showDialog(
                      context,
                      "Пропуск упражнения",
                      "Вы точно хотите пропустить текущее упражнение?",
                      () {
                        Navigator.pop(context, 'OK');
                        _destroy();
                      },
                    ),
                    Color(0xFFFFFFFF),
                  ),
                  Button(
                    Size(127, 40),
                    "Завершить",
                    () => _showDialog(
                      context,
                      "Завершить тренировку",
                      "Вы точно хотите завершить тренировку?",
                      () {
                        _timer?.cancel();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainChooseScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                    Color(0xFFEADDFF),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(
    BuildContext context,
    String title,
    String message,
    VoidCallback onOK,
  ) {
    _pauseTimer(); //Ставим на паузу при любом диалоге
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, "Cancel");
                  _resumeTimer();
                },
                child: Text("Отмена"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, "OK");
                  onOK();
                },
                child: Text("OK"),
              ),
            ],
          ),
    );
  }
}
