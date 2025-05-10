import 'package:flutter/material.dart';

class InputTextBox extends StatelessWidget{
  final String _hintText;
  final double _width;
  final double _height;
  final TextEditingController _controller;

  const InputTextBox(this._hintText, this._width, this._height, this._controller, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      height: _height,
      child: TextField(
        controller: _controller,
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