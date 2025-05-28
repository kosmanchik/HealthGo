import 'package:flutter/material.dart';
import 'package:health_go/screens/train_choice.dart';
import 'package:health_go/supportive_widgets/image_section.dart';
import 'package:health_go/supportive_widgets/button.dart';
import 'package:health_go/supportive_widgets/time_container.dart';
import 'dart:async';

class ExerciseScreen extends StatefulWidget {
  final ImageSection exerciseImage;
  final int secondsTime;
  final String exerciseInstruction; // Текст инструкции для упражнения

  const ExerciseScreen({
    Key? key,
    required this.exerciseImage,
    required this.secondsTime,
    required this.exerciseInstruction,
  }) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late int _remainingSeconds;
  late Timer _timer;
  bool _isTimerActive = true;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.secondsTime;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (!_isTimerActive) return;

      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          timer.cancel();
          _navigateBack();
        }
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _isTimerActive = false;
    });
  }

  void _resumeTimer() {
    setState(() {
      _isTimerActive = true;
    });
  }

  void _navigateBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void _showInstructionDialog() {
    _pauseTimer();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Инструкция'),
            content: SingleChildScrollView(
              child: Text(widget.exerciseInstruction),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _resumeTimer();
                },
                child: const Text('Закрыть'),
              ),
            ],
          ),
    );
  }

  void _showConfirmationDialog(
    String title,
    String message,
    VoidCallback onConfirm,
  ) {
    _pauseTimer();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _resumeTimer();
                },
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  String _formatTime(int seconds) {
    return '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3EDF7),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInstructionDialog,
            tooltip: 'Инструкция',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.exerciseImage,
            const SizedBox(height: 16),
            Container(
              height: 105,
              width: 235,
              decoration: BoxDecoration(
                color: const Color(0xFFECE6F0),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimeContainer(
                    _formatTime(_remainingSeconds).substring(0, 2),
                    const Color(0xFFE7E7E7),
                    const EdgeInsets.only(
                      left: 24,
                      right: 8,
                      bottom: 23,
                      top: 5,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 23),
                    child: const Text(
                      ":",
                      style: TextStyle(
                        fontSize: 57,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TimeContainer(
                    _formatTime(_remainingSeconds).substring(3),
                    const Color(0xFFE6E0E9),
                    const EdgeInsets.only(
                      right: 24,
                      left: 8,
                      bottom: 23,
                      top: 5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 23),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  const Size(127, 40),
                  "Пропустить",
                  () => _showConfirmationDialog(
                    "Пропуск тренировки",
                    "Вы точно хотите пропустить текущее упражнение?",
                    _navigateBack,
                  ),
                  const Color(0xFFFFFFFF),
                ),
                const SizedBox(width: 8),
                Button(
                  const Size(127, 40),
                  "Завершить",
                  () => _showConfirmationDialog(
                    "Завершение тренировки",
                    "Вы точно хотите завершить тренировку?",
                    () {
                      _timer.cancel();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrainChooseScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                  const Color(0xFFEADDFF),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
