import 'package:flutter/material.dart';
import 'dart:ui';

class FullBackgroundComponent extends StatelessWidget {
  final String background;
  final bool withBlur;
  const FullBackgroundComponent(
    this.background, {
    this.withBlur = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/' + background,
              ),
              fit: BoxFit.cover)),
      child: withBlur
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            )
          : null,
    );
  }
}
