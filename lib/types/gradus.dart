import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class Gradus {
  num value;
  Gradus({required this.value});

  String asString() {
    int result = (value - 273.15).round();
    if (Settings.getValue<int>('key-units', 1) == 0) {
      return '${((result * 9 / 5) + 32).round()} °F';
    }
    return '$result °C';
  }

  int asInt() {
    int result = (value - 273.15).round();
    if (Settings.getValue<int>('key-units', 1) == 0) {
      result = ((result * 9 / 5) + 32).round();
    }
    return result;
  }

  double asDouble() {
    return asInt().toDouble();
  }
}
