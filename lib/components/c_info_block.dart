import 'package:flutter/material.dart';
import 'components.dart';
import 'package:weather/size_config.dart';

class InfoBlockComponent extends StatelessWidget {
  final List<String> header;
  // ignore: prefer_typing_uninitialized_variables
  final Widget body;

  const InfoBlockComponent({
    required this.header,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(
          top: getPaddingX2() * 2, left: getPaddingX2(), right: getPaddingX2()),
      child: Column(children: [
        HeaderComponent(header[0], header[1]),
        Container(padding: EdgeInsets.all(getPadding()), child: body),
      ]),
    );
  }
}
