import 'package:flutter/material.dart';
import 'package:weather/components/components.dart';
import 'package:weather/utils/check_connection.dart';

class BottomBar extends StatelessWidget {
  final dynamic weather;
  const BottomBar({Key? key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: IconComponent('info.svg', size: 35),
            onPressed: () async {
              if (!await hasConnection()) {
                showOfflineModeException(context);
              } else {
                Navigator.pushNamed(context, '/info',
                    arguments: <String, dynamic>{
                      'weather': weather,
                    });
              }
            },
          ),
          IconButton(
            icon: IconComponent('sliders-horizontal.svg', size: 35),
            onPressed: () {
              Navigator.pushNamed(context, '/settings',
                  arguments: <String, String>{
                    'data': 'Berlin',
                  });
            },
          ),
          IconButton(
            icon: IconComponent('help-circle.svg', size: 35),
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }
}
