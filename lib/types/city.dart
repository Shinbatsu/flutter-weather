import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:translator/translator.dart';

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
    final translator = GoogleTranslator();
    String res = text;
    try {
      translator.translate(text, to: 'en').then((value) {
        res = value.text;
      });
    } finally {
      return res;
    }
    //if (isRussianWord(text)) {
    //  translator.translate(text, to: 'en').then((value) {
    //    return value;
    //  });
    //return Translit().toTranslit(source: text);
    //return text;
  }

  Future<String> translate() async {
    int language = Settings.getValue<int>('key-lang', 0);
    String res = text;
    final translator = GoogleTranslator();
    try {
      if (language == 0) {
        await translator.translate(text, to: 'ru').then((value) {
          res = value.text;
        });
      } else {
        await translator.translate(text, to: 'en').then((value) {
          res = value.text;
        });
      }
    } catch (e) {
      return text;
    } finally {
      return res;
    }
  }
}
