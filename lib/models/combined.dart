import 'weather_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<NextWeather> fetchAll(city) async {  
  dynamic response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?appid=521cf9ed7cda5e108034814bc98a51d7&q=' +
          city));
  if (response.statusCode == 200) {
    dynamic result = jsonDecode(response.body);
    final next7 = fetchNextWeather(
        lat: result['coord']['lat'].toDouble(),
        lon: result['coord']['lon'].toDouble());
    return next7;
  }
  throw 'Error';
}
