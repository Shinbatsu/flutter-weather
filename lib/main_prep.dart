import 'dart:math';
import 'services/notifyer.dart';
import 'package:weather/constants.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Функиция подготовки к запуску основной функции.
Future<void> initSubsystem() async {
  /// Убеждение в инициализации всех асинхронных сервисов.
  WidgetsFlutterBinding.ensureInitialized();

  /// Подключение переменных среды [Api-keys].
  await dotenv.load(fileName: ".env");

  /// Подключение сервиса уведомлений.
  await NotificationService().initNotification();

  /// Загрузка пользовательских настроек.
  await Settings.init(
    cacheProvider: SharePreferenceCache(),
  );
}

/// Функция создание случайной темы.
List<dynamic> createTheme() {
  bool isStaticBG = Settings.getValue<bool>('key-static_background', false);

  /// Если включен режим статического Фона.
  if (isStaticBG) {
    int idx = Settings.getValue<int>('key-background-id', 0);
    return themes[idx];
  } else {
    final Random rand = Random();
    return themes[rand.nextInt(13)];
  }
}

/// Генерация темы и всех цветовых схем.
List<dynamic> initTheme() {
  List<dynamic> someTheme = createTheme();
  String appBackground = someTheme[0];
  Color primaryColorLight = someTheme[1];
  Color primaryColor = someTheme[2];
  Color primaryColorDark = someTheme[3];
  return [
    appBackground,

    /// Создание объекта темы и ее заполнение цветовой палитрой
    /// Подключение основного шрифта [Montserrat] и дополниьельного
    /// [Roboto].
    ThemeData(

        /// Фон в случае отстутствия изображения.
        backgroundColor: const Color(0xFFEEEEEE),

        /// Разделители слайдера.
        dividerColor: Colors.transparent,

        /// Светлый акцент основного цвета.
        primaryColorLight: primaryColorLight,

        /// Основной цвет.
        primaryColor: primaryColor,

        /// Темный акцент основного цвета.
        primaryColorDark: primaryColorDark,

        /// Прозрачный фон каждого экрана.
        scaffoldBackgroundColor: Colors.transparent,

        /// Цвет неактивного состояния компонента.
        unselectedWidgetColor: primaryColor,

        /// Цвет активного состояния компонента.
        toggleableActiveColor: primaryColorLight,

        /// Цветовая схема для [Actions] и других типов
        /// при взаимодействии пользователя.
        colorScheme: ColorScheme(
          primary: primaryColor,
          onPrimary: primaryColor,
          brightness: Brightness.dark,
          secondary: primaryColorLight,
          onSecondary: primaryColorLight,
          surface: primaryColorDark,
          background: primaryColor,
          error: primaryColor,
          onSurface: primaryColor,
          onBackground: primaryColor,
          onError: Colors.redAccent,
        ),

        /// Основной шрифт программы.
        fontFamily: "Montserrat",
        canvasColor: Colors.transparent,

        /// Описание стилей для шрифтов.
        textTheme: TextTheme(
            headline6: TextStyle(fontFamily: 'Roboro'),
            bodyText1: TextStyle(
                color: kTextColor, fontWeight: FontWeight.w700, fontSize: 20),
            bodyText2: TextStyle(color: kTextColor)))
  ];
}
