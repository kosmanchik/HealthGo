import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget
{
  final String _buttonText; //текст кнопки
  final VoidCallback _onPressed; //функция, вызывающиеся на нажатие кнопки
  final Icon? _icon; //иконка для отображения на кнопке
  final Size _buttonSize;

  const ButtonIcon(this._icon, this._buttonSize, this._buttonText, this._onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    if (_icon != null) {
      return ElevatedButton.icon( 
        style: GetStandartStyle(),
        onPressed: _onPressed, 
        icon: _icon, 
        label: Text(_buttonText)
      );
    }
      
    return ElevatedButton( 
      style: GetStandartStyle(),
      onPressed: _onPressed,
      child: Text(_buttonText)
    );
  }

  ButtonStyle GetStandartStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFECE6F0),
      foregroundColor: Color(0xFF65558F),
      minimumSize: _buttonSize,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      )
    );
  }
}