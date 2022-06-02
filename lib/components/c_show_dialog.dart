import 'package:flutter/material.dart';
import 'package:weather/types/translated_text.dart';

Future openDialog({context}) async {
  TextEditingController controller = TextEditingController();
  return await showDialog(
    barrierColor: Colors.white.withOpacity(0),
    context: context,
    builder: (context) => AlertDialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          Translated('Введите название города').translate(),
        ),
        content: TextField(
          controller: controller,
          onSubmitted: (String? newValue) {},
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: Translated('Например: Москва').translate(),
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColorDark.withOpacity(0.6))),
                child: Text(
                  Translated('Узнать погоду!').translate(),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context, controller.text);
                },
              ),
            ],
          )
        ]),
  );
}
