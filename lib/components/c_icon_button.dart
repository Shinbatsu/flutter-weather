import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/size_config.dart';

class IconButtonComponent extends StatelessWidget {
  final String icon;
  final double size;
  final Color color;
  final VoidCallback onPressed;
  final List<double> padding;

  const IconButtonComponent(
    this.icon, {
    required this.onPressed,
    this.size = 20,
    this.color = Colors.white,
    this.padding = const [0, 0, 0, 0],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return IconButton(
      splashRadius: 1,
      padding: EdgeInsets.only(
        top: padding[0],
        right: padding[1],
        bottom: padding[2],
        left: padding[3],
      ),
      iconSize: 50,
      icon: SvgPicture.asset('assets/icons/' + icon,
          width: getProportionateScreenWidth(size),
          height: getProportionateScreenWidth(size),
          color: color),
      onPressed: onPressed,
    );
  }
}
