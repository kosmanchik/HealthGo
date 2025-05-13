import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final VoidCallback _onPressed;
  final String _buttonText;
  final Color _buttonColor;
  final Size _buttonSize;
  Color _textColor = Color(0xFF65558F);
  
  Button(this._buttonSize, this._buttonText, this._onPressed, this._buttonColor, {super.key});

  Button.withCustomTextColor(this._buttonSize, this._buttonText, this._onPressed, this._buttonColor, this._textColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _buttonColor,
        minimumSize: _buttonSize,
        foregroundColor: _textColor,
      ),
      onPressed: _onPressed, 
      child: Text(_buttonText)
    );
  }
}