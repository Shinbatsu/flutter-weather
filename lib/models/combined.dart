import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather.dart';

Future<NextWeather> fetchWeatherByCoords(
    {dynamic lat = 55.7522, dynamic lon = 37.6156}) async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?&exclude=&appid=521cf9ed7cda5e108034814bc98a51d7&lat=' +
          lat.toString() +
          '&lon=' +
          lon.toString()));
  if (response.statusCode == 200) {
    return NextWeather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<NextWeather> fetchAll(city) async {
  dynamic response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?appid=521cf9ed7cda5e108034814bc98a51d7&q=' +
          city));
  if (response.statusCode == 200) {
    dynamic responseBody = jsonDecode(response.body);
    Map<String, double> coords = {
      'lat': responseBody['coord']['lat'].toDouble(),
      'lon': responseBody['coord']['lon'].toDouble()
      };
    final next7 = fetchWeatherByCoords(
        lat: coords['lat'],
        lon: coords['lon']
        );
    return next7;
  }
  throw 'Error';
}
