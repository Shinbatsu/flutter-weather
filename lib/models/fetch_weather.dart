import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String? coordLink = dotenv.env['COORDLINK'];
final String? weatherLink = dotenv.env['WEATHERLINK'];
final String? appid = dotenv.env['APPID'];

Future<NextWeather> fetchWeatherByCoords(
    {required double? lat, required double? lon}) async {
  final response = await http.get(Uri.parse(
      '$weatherLink&exclude=&appid=$appid&lat=' +
          lat.toString() +
          '&lon=' +
          lon.toString()));
  if (response.statusCode == 200) {
    return NextWeather.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to load');
}

Future<NextWeather> fetchWeatherByName(String city) async {
  dynamic response =
      await http.get(Uri.parse('${coordLink}appid=$appid&q=' + city));
  if (response.statusCode == 200) {
    dynamic responseBody = jsonDecode(response.body);
    Map<String, double> coords = {
      'lat': responseBody['coord']['lat'].toDouble(),
      'lon': responseBody['coord']['lon'].toDouble()
    };
    final next7 = fetchWeatherByCoords(lat: coords['lat'], lon: coords['lon']);
    return next7;
  }
  throw 'Error';
}
