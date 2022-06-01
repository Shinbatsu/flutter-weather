import 'package:flutter/material.dart';
import 'package:weather/size_config.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final int headerLvl;
  const HeaderText(this.text, {this.headerLvl = 3, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: getHeader()),
    );
  }
}
