import 'package:flutter/material.dart';
import 'package:health_go/supportive_widgets/image_section.dart';

class AchievementWidget extends StatelessWidget {
  final String _heading;
  final String _bodyText;
  final ImageSection _imageSection;

  const AchievementWidget(this._imageSection, this._heading, this._bodyText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 30,
      children: [
        _imageSection,

        Expanded(
          child: Center(child: RichText(
          text: TextSpan(
            text: "$_heading\n",
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 18,
            ),
            children: <TextSpan>[
              TextSpan(
                text: _bodyText,
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              )
            ]
          ),
          textAlign: TextAlign.center,
        ))),
      ],
    );
  }
}