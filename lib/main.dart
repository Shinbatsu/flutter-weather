import 'package:flutter/material.dart';
import 'routes.dart';
import 'main_prep.dart';
import 'adapters/weather_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';

/// Главная функция,точка запуска программы.
void main() async {
  /// Инициализации сервиса базы данных.
  await Hive.initFlutter();

  /// Регистрация пользовательского типа данных.
  Hive.registerAdapter(WeatherAdapter());

  /// Запуск инициализации дополнительного сервиса [initTheme] и
  /// функции нальной отрисовки приложения [runApp].
  initSubsystem().then((_) {
    List<dynamic> prepareData = initTheme();
    runApp(MyApp(appBackground: prepareData[0], themeData: prepareData[1]));
  });
}

///Главный виджет программы, он содержит конструктор с темой и фоном.
class MyApp extends StatelessWidget {
  final String appBackground;
  final ThemeData themeData;
  const MyApp({required this.appBackground, required this.themeData, Key? key})
      : super(key: key);

  /// Переопределение абстрактного метода у класс [StatelessWidget]
  /// этот метод нужен для описания в нем логики отрисовки и обновления
  /// виджета на экране.
  @override
  Widget build(BuildContext context) {
    /// Фиксирование портретной ориентации приложения.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      /// Название приложения.
      title: 'Weather',

      /// Добавление программы.
      theme: themeData,

      /// Отключить метку 'Debug' вверху справа.
      debugShowCheckedModeBanner: false,

      /// Начальный маршрут приложения, он подгружает [routes/HomeScreen].
      initialRoute: '/',

      /// Передача Функции, которая возвращает карту путей "routes",
      /// для навигации между экранами.
      routes: createRoutes(appBackground: appBackground),
    );
  }
}
