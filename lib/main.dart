import 'package:flutter/material.dart';
import 'routes.dart';
import 'main_prep.dart';
import 'adapters/weather_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WeatherAdapter());
  initSubsystem().then((_) {
    List<dynamic> prepareData = initTheme();
    runApp(MyApp(appBackground: prepareData[0], themeData: prepareData[1]));
  });
}

class MyApp extends StatelessWidget {
  final String appBackground;
  final ThemeData themeData;
  const MyApp({required this.appBackground, required this.themeData, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: createRoutes(appBackground: appBackground),
    );
  }
}
