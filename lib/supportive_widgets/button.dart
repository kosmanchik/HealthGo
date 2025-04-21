import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final VoidCallback _onPressed;
  final String _buttonText;
  final Color _buttonColor;
  final Size _buttonSize;
  const Button(this._buttonSize, this._buttonText, this._onPressed, this._buttonColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _buttonColor,
        minimumSize: _buttonSize,
        foregroundColor: Color(0xFF65558F)
      ),
      onPressed: _onPressed, 
      child: Text(_buttonText)
    );
  }
}