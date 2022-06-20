import 'package:flutter/material.dart';
import 'screens/screens.dart';

/// Создание дерева маршрутов между экранами.
Map<String, Widget Function(BuildContext)> createRoutes({appBackground}) {
  return {
    /// Путь к начальному экрану [HomeScreen].
    '/': (context) => HomeScreen(appBackground: appBackground),

    /// Путь к экрану с допольнительной информацией на день [InfoScreen].
    '/info': (context) => InfoScreen(appBackground: appBackground),

    /// Путь к экрану настроек приложения [SettingsScreen].
    '/settings': (context) =>
        SettingsScreen(appBackground: appBackground, data: 'Hell'),

    /// Путь к экрану со справочной информацией [AboutScreen].
    '/about': (context) => AboutScreen(appBackground: appBackground),
  };
}
