import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class Translated {
  final String text;
  Translated(this.text);
  bool isEnglishWord(String word) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(word);
  }

  bool isRussianWord(String word) {
    return RegExp(r'^[а-яё -0-9]+$').hasMatch(word);
  }

  String translate() {
    int language = Settings.getValue<int>('key-lang', 0);
    //if (text == 'Clouds') {
    //  return 'Облачно';
    //}
    if (language == 0) {
      if (isRussianWord(text)) {
        return text;
      }
      return enRuDict[text] ?? text;
    } else {
      if (isEnglishWord(text)) {
        return text;
      }
      return ruEnDict[text] ?? text;
    }
  }
}

var enRuDict = {};
var ruEnDict = {
  'Понедельник': 'Monday',
  'Вторник': 'Tuesday',
  'Среда': 'Wednesday',
  'Четверг': 'Thrusday',
  'Пятница': 'Friday',
  'Суббота': 'Saturday',
  'Воскресенье': 'Sunday',
  'Январь': 'January',
  'Февраль': 'February',
  'Март': 'March',
  'Апрель': 'April',
  'Май': 'May',
  'Июнь': 'June',
  'Июль': 'July',
  'Солнечный цикл': 'Sun Cycle',
  'Расположение': 'Location',
  'Август': 'August',
  'Сентябрь': 'September',
  'Октябрь': 'October',
  'Ноябрь': 'November',
  'Декабрь': 'December',
  'Общие Настройки': 'Common Settings',
  'Сохранять Последнюю Сессию': 'Save Last Session',
  'Присылать Уведомления': 'Send Notifications',
  'Отображение Температуры': 'Temperature Displaying',
  'Градус Фаренгейта': 'Fahrenheit Unit',
  'Градус Цельсия': 'Celsius Unit',
  'Фон и Цвет': 'Background and Color',
  'Статический Фон': 'Static Background',
  'Задний Фон': 'Background',
  'Языковые Настройки': 'Language Settings',
  'Язык': 'Language',
  'Предупреждение': 'Warning',
  'Некоторые настройки вступят в силу только после перезагрузки':
      'Some settings require a reboot of the application',
  'Важные События': 'Important Events',
  'Гроза': 'Lighting',
  'Снегопад': 'Snowfall',
  'Температура': 'Temperature',
  'Влажность': 'Humidity',
  'Ветер': 'Wind',
  'Восход': 'Sunrise',
  'Закат': 'Sunrset',
  'Закрыть': 'Close',
  'Clouds': 'Облачно',
  'Разработчики': 'Developers',
  'Матвей Купцов (SparkieAG)': 'Matvei Kuptsov (SparkieAG)',
  'Юрий Васькевич (LinerS)': 'Yuri Vaskevich (LinerS)',
  'Логика Работы': 'Programming',
  'Дизайн и Интерфейс': 'Design and Interface',
  'Данное приложение разрабатывалось в учебных целях и является дипломным проектом, разработка велась внутри команды из двух человек, каждый из которых отвечал за определенную часть приложения, все данные взяты из открытых источников.':
      'This app is developed only for education benefits and is a graduate project, this app was developed inside of a team which had two developers, so each of them is responsible for concrete part of app',
  'Информация': 'Information',
  'Недоступно в Offline режиме': 'Not allowed in offline mode',
  'Широта': 'Latitude',
  'Долгота': 'Longitude',
};
