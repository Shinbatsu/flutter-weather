import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconComponent extends StatelessWidget {
  final String icon;
  final double size;
  final Color color;
  final List<double> padding;

  const IconComponent(
    this.icon, {
    this.size = 25,
    this.color = Colors.white,
    this.padding = const [0, 0, 0, 0],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/icons/' + icon,
        width: size, height: size, color: color);
  }
}
