import 'package:flutter/material.dart';
import 'package:weather/components/components.dart';
import 'package:weather/types/translated_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class BottomBar extends StatelessWidget {
  final dynamic weather;
  const BottomBar({Key? key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showOfflineModeException() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(Translated('Предупреждение').translate(),
                      style: TextStyle(fontFamily: 'Roboto')),
                  Text(
                      '${Translated("Недоступно в Offline режиме").translate()}!',
                      style: TextStyle(fontFamily: 'Roboto')),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColorLight)),
                    child: Text(Translated('Закрыть').translate(),
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Roboto')),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return Container(
      padding: EdgeInsets.all(30),
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: IconComponent('info.svg', size: 35),
            onPressed: () async {
              if (await Connectivity().checkConnectivity() ==
                  ConnectivityResult.none) {
                showOfflineModeException();
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
