import 'package:hive/hive.dart';

part 'weather_adapter.g.dart';
 
 @HiveType(typeId: 4)
class Weather {

  @HiveField(0)
  final List<List<dynamic>> daily;

  @HiveField(1)
  final List<List<dynamic>> hourly;

  @HiveField(2)
  final num lat;

  @HiveField(3)
  final num lon;

  @HiveField(4)
  final num sunrise;

  @HiveField(5)
  final num sunset;

  @HiveField(6)
  final List<int> hourlyTemp;

  @HiveField(7)
  final List<int> hourlyHumidity;

  @HiveField(8)
  final num temp;

  @HiveField(9)
  final num tempMin;

  @HiveField(10)
  final num tempMax;

  @HiveField(11)
  final String weatherType;

  @HiveField(12)
  final num windSpeed;

  @HiveField(13)
  final num windDeg;

  @HiveField(14)
  final int dateDay;

  @HiveField(15)
  final int dateMonth;
  const Weather({
    required this.daily,
    required this.hourly,
    required this.lat,
    required this.lon,
    required this.sunrise,
    required this.sunset,
    required this.hourlyTemp,
    required this.hourlyHumidity,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.weatherType,
    required this.windSpeed,
    required this.windDeg,
    required this.dateDay,
    required this.dateMonth,
  });
}
