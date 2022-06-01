import 'package:flutter/material.dart';

class DarkerBackgroundComponent extends StatelessWidget {
  final double opacity;
  const DarkerBackgroundComponent(
    this.opacity, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(color: Colors.black.withOpacity(opacity)),
    );
  }
}
