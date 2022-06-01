import 'package:flutter/material.dart';
import 'components.dart';
import 'package:weather/size_config.dart';

class HeaderComponent extends StatelessWidget {
  final String icon;
  final String title;
  const HeaderComponent(
    this.icon,
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconComponent(
            icon,
          ),
          SizedBox(width: getPadding()),
          HeaderText(title),
        ],
      ),
      width: double.maxFinite,
      height: getProportionateScreenHeight(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
