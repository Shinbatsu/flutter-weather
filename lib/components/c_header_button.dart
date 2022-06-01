import 'package:flutter/material.dart';
import 'components.dart';
import 'package:weather/size_config.dart';

class HeaderButtonComponent extends StatelessWidget {
  final IconButtonComponent button;
  final String icon;
  final String title;
  const HeaderButtonComponent(
    this.icon,
    this.title, {
    required this.button,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconComponent(
            icon,
          ),
          SizedBox(width: 10),
          Text(title, style: TextStyle(fontSize: 20, color: Colors.white)),
        ],
      ),
      width: double.maxFinite,
      height: getProportionateScreenHeight(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
