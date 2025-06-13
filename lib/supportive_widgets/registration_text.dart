import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationText extends StatelessWidget {
  final double _width;
  final double _height;
  final String _text;

  const RegistrationText(this._text, this._width, this._height, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: Text(
        _text, 
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: Color(0xFF000000)), 
        textAlign: TextAlign.center
      ),
    );
  }
}