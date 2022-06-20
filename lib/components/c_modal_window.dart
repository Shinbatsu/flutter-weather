import 'package:flutter/material.dart';
import 'package:weather/types/translated_text.dart';
import 'package:hive/hive.dart';

/// Сохраняем факт изменения значей в базу данных
void makeChange() async {
  var box = await Hive.openBox('Storage');
  box.put('sync', false);
}

/// Функция вызова модального окна
void showModal(BuildContext ctx) {
  /// В случае изменений которые привели к вызову,
  /// мы фиксируем их а Базе данных настроек.
  makeChange();

  /// Отрисовываем Модальное окно с предупреждением
  showModalBottomSheet<void>(
    /// передаем контекст чтобы окно отрисовалось там где нужно.
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
              Text(
                  '${Translated("Некоторые настройки вступят в силу только после перезагрузки").translate()}!',
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
