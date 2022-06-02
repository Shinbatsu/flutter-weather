class NextWeather {
  final List<List<dynamic>> daily;
  final List<List<dynamic>> hourly;
  final num lat;
  final num lon;
  final num sunrise;
  final num sunset;
  final List<int> hourlyTemp;
  final List<int> hourlyHumidity;
  final num temp;
  final num tempMin;
  final num tempMax;
  final String weatherType;
  final num windSpeed;
  final num windDeg;
  final int dateDay;
  final int dateMonth;
  const NextWeather({
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

  factory NextWeather.fromJson(Map<String, dynamic> json) {
    List<List<dynamic>> dailyParse(obj) {
      List<List<dynamic>> res = [];
      for (int i = 0; i < 7; i++) {
        res.add([
          obj[i]['temp']['day'],
          obj[i]['weather'][0]['description'].toLowerCase().replaceAll(' ', ''),
        ]);
      }
      return res;
    }

    List<int> hourlyTemp(obj) {
      List<int> res = [];
      for (int i = 1; i < 24; i++) {
        res.add(
          obj[i]['temp'].round(),
        );
      }
      return res;
    }

    List<int> hourlyHumidity(obj) {
      List<int> res = [];
      for (int i = 1; i < 24; i++) {
        res.add(
          obj[i]['humidity'],
        );
      }
      return res;
    }

    List<List<dynamic>> hourlyParse(obj) {
      List<List<dynamic>> res = [];
      for (int i = 1; i < 24; i++) {
        res.add([
          obj[i]['temp'],
          obj[i]['humidity'],
        ]);
      }
      return res;
    }

    //DateFormat formatter=DateFormat('yyyy-MM-dd – kk:mm').Hm();
    return NextWeather(
      daily: dailyParse(json['daily']),
      hourly: hourlyParse(json['hourly']),
      lat: json['lat'],
      lon: json['lon'],
      sunrise: json['current']['sunrise'],
      sunset: json['current']['sunset'],
      hourlyTemp: hourlyTemp(json['hourly']),
      hourlyHumidity: hourlyHumidity(json['hourly']),
      temp: json['current']['temp'],
      tempMin: json['daily'][0]['temp']['min'],
      tempMax: json['daily'][0]['temp']['max'],
      weatherType: json['current']['weather'][0]['main'],
      windSpeed: json['current']['wind_speed'],
      windDeg: json['current']['wind_deg'],
      dateDay: DateTime.now().day,
      dateMonth: DateTime.now().month,
    );
  }
}
