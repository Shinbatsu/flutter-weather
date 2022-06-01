import 'package:flutter/material.dart';
import 'package:weather/size_config.dart';

class ParagraphText extends StatelessWidget {
  final String text;
  const ParagraphText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: getParagraph()),
    );
  }
}
