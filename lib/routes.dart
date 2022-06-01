import 'package:flutter/material.dart';
import 'screens/screens.dart';

Map<String, Widget Function(BuildContext)> createRoutes({appBackground}) {
  return {
    '/': (context) => HomeScreen(appBackground: appBackground),
    '/info': (context) =>
        InfoScreen(appBackground: appBackground),
    '/settings': (context) =>
        SettingsScreen(appBackground: appBackground, data: 'Hell'),
    '/about': (context) => AboutScreen(appBackground: appBackground),
  };
}
