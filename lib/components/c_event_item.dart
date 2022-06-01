import 'package:flutter/material.dart';
import 'package:weather/size_config.dart';
import 'components.dart';

class EventItemComponent extends StatelessWidget {
  final String icon;
  final String event;
  final String time;
  const EventItemComponent(
    this.icon,
    this.event,
    this.time, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(20)),
      margin: EdgeInsets.only(
          left: getProportionateScreenHeight(20),
          right: getProportionateScreenHeight(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              IconComponent(
                icon,
              ),
              SizedBox(
                width: getPadding(),
              ),
              ParagraphText(event + ':'),
            ],
          ),
          ParagraphText(time),
        ],
      ),
    );
  }
}
