import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:translit/translit.dart';

class City {
  final String text;
  City(this.text);
  bool isEnglishWord(String word) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(word);
  }

  bool isRussianWord(String word) {
    return RegExp(r'^[а-яё -0-9]+$').hasMatch(word);
  }

  String englify() {
    if (isRussianWord(text)) {
      return Translit().toTranslit(source: text);
    }
    return text;
  }

  String translate() {
    int language = Settings.getValue<int>('key-lang', 0);
    if (language == 0) {
      if (isRussianWord(text)) {
        return text;
      }
      if (text == 'Moscow' || text == 'moscow') {
        return 'Москва';
      }
      return Translit().unTranslit(source: text);
    } else {
      if (isEnglishWord(text)) {
        return text;
      }
      return Translit().toTranslit(source: text);
    }
  }
}
