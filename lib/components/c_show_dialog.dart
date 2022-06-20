import 'package:flutter/material.dart';
import 'package:weather/types/translated_text.dart';

Future openDialog({context}) async {
  /// Контроллер для текстового поля, хранит ввод пользователя.
  TextEditingController controller = TextEditingController();

  /// Функция показывающая открытие диалога с погодой.
  return await showDialog(
    barrierColor: Colors.white.withOpacity(0),
    context: context,

    /// Отображение диалога на основе состояния системы.
    /// По умолчанию запускается классический диалог.
    builder: (context) => AlertDialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          Translated('Введите название города').translate(),
        ),

        /// Текстовое поле для ввода города.
        content: TextField(
          controller: controller,

          /// Отключение стандартного поведения для поля.
          onSubmitted: (String? newValue) {},
          style: TextStyle(color: Colors.white),

          /// Логика для поля "Текст по умолчанию и его цвет".
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: Translated('Например: Москва').translate(),
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),

        /// Центральная кнопка для выполнения запроса погоды.
        actions: [
          Row(
            /// Центрирование кнопки
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                /// Стилизация кнопки.
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColorDark.withOpacity(0.6))),

                /// Текст на кнопке.
                child: Text(
                  Translated('Узнать погоду!').translate(),
                  style: TextStyle(color: Colors.white),
                ),

                /// Callback для передачи данных из функции.
                onPressed: () {
                  Navigator.pop(context, controller.text.trim());
                },
              ),
            ],
          )
        ]),
  );
}
