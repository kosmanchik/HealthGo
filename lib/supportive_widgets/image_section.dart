import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget //класс секции с изображением
{
  final String _imagePath;

  const ImageSection(this._imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container( //контейнер с изображением
      alignment: Alignment.center,
      child: Image.asset(_imagePath)
    );
  }
}