import 'package:flutter/material.dart';

class TextSection extends StatelessWidget{
  final String _text;

  TextSection(this._text);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 167, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, 
          width: 1, 
        ),
        borderRadius: BorderRadius.circular(8) 
      ),
      child: Text(_text, 
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          )
      )
    );
  }
}