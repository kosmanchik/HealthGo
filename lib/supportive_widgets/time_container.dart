import 'package:flutter/material.dart';

class TimeContainer extends StatelessWidget{ //Класс контейнеров в которых хранятся минуты и секунды
  final String _time;
  final Color _containerColor;
  final EdgeInsets _margin;

  const TimeContainer(this._time, this._containerColor, this._margin, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      width: 81.5,
      height: 72,
      decoration: 
        BoxDecoration(
          color: _containerColor,
          borderRadius: BorderRadius.circular(8),
        ),
      child: Center( child: Text(_time.padLeft(2, '0'), 
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.w400,
            )
          ) 
      )
    );
  }
}