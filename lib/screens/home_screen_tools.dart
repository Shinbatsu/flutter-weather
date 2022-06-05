import 'package:weather/models/weather_service.dart';
import 'package:hive/hive.dart';
import 'package:weather/adapters/weather_adapter.dart';

Future<NextWeather> getWeatherFromStorage() async {
  var box = await Hive.openBox('Weathers');
  var storageWeather = box.get('latestWeather');
  return NextWeather(
    daily: storageWeather.daily,
    hourly: storageWeather.hourly,
    lat: storageWeather.lat,
    lon: storageWeather.lon,
    sunrise: storageWeather.sunrise,
    sunset: storageWeather.sunset,
    hourlyTemp: storageWeather.hourlyTemp,
    hourlyHumidity: storageWeather.hourlyHumidity,
    temp: storageWeather.temp,
    tempMin: storageWeather.tempMin,
    tempMax: storageWeather.tempMax,
    weatherType: storageWeather.weatherType,
    windSpeed: storageWeather.windSpeed,
    windDeg: storageWeather.windDeg,
    dateDay: storageWeather.dateDay,
    dateMonth: storageWeather.dateMonth,
  );
}

void saveResponse(String city, NextWeather weather) async {
  Weather savedWeather = Weather(
    daily: weather.daily,
    hourly: weather.hourly,
    lat: weather.lat,
    lon: weather.lon,
    sunrise: weather.sunrise,
    sunset: weather.sunset,
    hourlyTemp: weather.hourlyTemp,
    hourlyHumidity: weather.hourlyHumidity,
    temp: weather.temp,
    tempMin: weather.tempMin,
    tempMax: weather.tempMax,
    weatherType: weather.weatherType,
    windSpeed: weather.windSpeed,
    windDeg: weather.windDeg,
    dateDay: weather.dateDay,
    dateMonth: weather.dateMonth,
  );
  var box = await Hive.openBox('Weathers');
  await box.put('latestWeather', savedWeather);
  await box.put('latestCity', city);
}

Future<String> getCityFromStorage() async {
  var box = await Hive.openBox('Weathers');
  String storageCity = box.get('latestCity', defaultValue: 'Korolyov');
  return storageCity;
}
