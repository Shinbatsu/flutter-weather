import 'package:flutter/material.dart';
import 'package:weather/types/translated_text.dart';

class CityNotFound extends StatelessWidget {
  String city;
  CityNotFound(this.city, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (city.length > 18) {
      city = city.substring(0, 15) + '...';
    }
    return Center(
        child: Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Theme.of(context).primaryColor.withOpacity(0.5)),
      width: 300,
      height: 400,
      child: Column(
        children: [
          SizedBox(height: 40),
          Text(
            '🤔',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35),
          ),
          SizedBox(height: 40),
          Center(
            child: Text(
              '${Translated("Город c названием").translate()}: $city ${Translated("не найден").translate()}!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    ));
  }
}
