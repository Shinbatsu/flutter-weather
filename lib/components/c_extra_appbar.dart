import 'package:flutter/material.dart';
import 'c_icon_button.dart';
import 'package:weather/size_config.dart';

class ExtraAppBarComponent extends StatelessWidget with PreferredSizeWidget {
  const ExtraAppBarComponent({
    Key? key,
  }) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return PreferredSize(
      preferredSize: Size.fromHeight(getProportionateScreenHeight(200)),
      child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButtonComponent('chevron-left.svg', size: 20,
              onPressed: () {
            Navigator.pop(context);
          }, padding: const [0, 0, 0, 30])),
    );
  }
}
