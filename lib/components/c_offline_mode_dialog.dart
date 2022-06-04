import 'package:flutter/material.dart';
import 'package:weather/types/types.dart';

void showOfflineModeException(BuildContext ctx) {
  showModalBottomSheet<void>(
    context: ctx,
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
              Text('${Translated("Недоступно в Offline режиме").translate()}!',
                  style: TextStyle(fontFamily: 'Roboto')),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColorLight)),
                child: Text(Translated('Закрыть').translate(),
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Roboto')),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      );
    },
  );
}
