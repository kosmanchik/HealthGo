import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget
{
  final String _buttonText; //текст кнопки
  final VoidCallback _onPressed; //функция, вызывающиеся на нажатие кнопки
  final Icon? _icon; //иконка для отображения на кнопке
  final Size _buttonSize;
  Color _buttonColor = Color(0xFFECE6F0);
  Color _buttonFontColor = Color(0xFF65558F);

  ButtonIcon.withStandardColor(this._icon, this._buttonSize, this._buttonText, this._onPressed, {super.key});
  ButtonIcon(this._icon, this._buttonSize, this._buttonText, this._onPressed, this._buttonColor, this._buttonFontColor,{super.key});

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
      backgroundColor: _buttonColor,
      foregroundColor: _buttonFontColor,
      minimumSize: _buttonSize,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      )
    );
  }
}