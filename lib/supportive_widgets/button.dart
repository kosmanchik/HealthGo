import 'package:flutter/material.dart';

class Button extends StatelessWidget
{
  final String _buttonText; //текст кнопки
  final VoidCallback _onPressed; //функция, вызывающиеся на нажатие кнопки
  final IconData _icon;

  const Button(this._icon, this._buttonText, this._onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon( 
        style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFECE6F0),
        foregroundColor: Color(0xFF65558F),
        minimumSize: Size(116.0, 56.0),
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),      
      onPressed: _onPressed, 
      icon: Icon(_icon),
      label: Text(_buttonText)
    );
  }
}