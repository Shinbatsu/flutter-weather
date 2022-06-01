import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'c_icon_button.dart';
import 'package:weather/size_config.dart';

class AppBarComponent extends StatelessWidget with PreferredSizeWidget {
  const AppBarComponent({
    Key? key,
  }) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Future openDialog() => showDialog(
          barrierColor: Colors.white.withOpacity(0),
          context: context,
          builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(getPadding()))),
              backgroundColor: Colors.black.withOpacity(0.5),
              title: Text(
                'Please enter a city!',
                style: TextStyle(color: Colors.white),
              ),
              content: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  hintText: 'City',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              actions: [
                TextButton(
                    child: Text(
                      'Find Weather',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {})
              ]),
        );
    return PreferredSize(
      preferredSize: Size.fromHeight(getProportionateScreenHeight(200)),
      child: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButtonComponent('search.svg', onPressed: () {
          openDialog();
        }, padding: const [0, 0, 0, 30]),
        actions: [
          IconButtonComponent('globe.svg',
              size: getPadding(),
              onPressed: () {},
              padding: [0, getPadding(), 0, 0])
        ],
      ),
    );
  }
}
