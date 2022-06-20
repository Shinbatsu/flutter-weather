import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/types/city.dart';

/// Загрузка данных из переменного окружения.
/// Это необходимо для безопасной манипуляции с ключами [API-keys].
final String? coordLink = dotenv.env['COORDLINK'];
final String? weatherLink = dotenv.env['WEATHERLINK'];
final String? appid = dotenv.env['APPID'];

/// Ассинхронная функция для поиска погоды по КООРДИНАТАМ, является частью
/// основной функции поиска по ГОРОДУ.
Future<NextWeather> fetchWeatherByCoords(
    {required double? lat, required double? lon}) async {
  /// Создание переменной, в которую будет записан запрос погоды.
  final response = await http.get(Uri.parse(
      '$weatherLink&exclude=&appid=$appid&lat=' +
          lat.toString() +
          '&lon=' +
          lon.toString()));
  if (response.statusCode == 200) {
    /// Возвращаем список данных декодированный из Json-объекта.
    return NextWeather.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to load');
}

/// Ассинхронная функция, она выполняет запрос, пока запрос обрабатывается
/// мы выполняем другую полезную работу.
/// Future значит что данные [NextWeather] придут позже.
Future<NextWeather> fetchWeatherByName(String city) async {
  /// Стандартизация ввода пользователя для отправки запроса погоды.
  city = City(city).englify();

  /// Динамическая переменная которая хранит ответ запроса координат погоды.
  dynamic response =
      await http.get(Uri.parse('${coordLink}appid=$appid&q=' + city));

  /// Если ответ был удачный то вычислить погоду
  /// по координатам которые мы получили.
  if (response.statusCode == 200) {
    dynamic responseBody = jsonDecode(response.body);
    Map<String, double> coords = {
      'lat': responseBody['coord']['lat'].toDouble(),
      'lon': responseBody['coord']['lon'].toDouble()
    };

    /// Выполнение функции поиска погоды по координаьам в случае успеха.
    /// final значит что значение не меняется и присваивается прямо здесь и
    /// только один раз.
    final next7 = fetchWeatherByCoords(lat: coords['lat'], lon: coords['lon']);
    return next7;
  }

  /// Лог с ошибкой в случае какой-либо неполадки.
  throw 'Error';
}
