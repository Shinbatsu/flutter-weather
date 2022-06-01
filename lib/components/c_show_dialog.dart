import 'package:flutter/material.dart';

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
          'Введите название города',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          onSubmitted: (String? newValue) {},
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: 'Москва',
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
                        Theme.of(context).primaryColorLight)),
                child: Text(
                  'Узнать погоду',
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
