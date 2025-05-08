import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputTextBox extends StatelessWidget{
  final String _hintText;
  final double _width;
  final double _height;

  const InputTextBox(this._hintText, this._width, this._height, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      height: _height,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          hintText: _hintText,
        ),  
      ),
    );
  }  
}