import 'dart:math';
import 'services/notifyer.dart';
import 'package:weather/constants.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initSubsystem() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await NotificationService().initNotification();
  await Settings.init(
    cacheProvider: SharePreferenceCache(),
  );
}

List<dynamic> createTheme() {
  bool isStaticBG = Settings.getValue<bool>('key-static_background', false);
  if (isStaticBG) {
    int idx = Settings.getValue<int>('key-background-id', 0);
    return themes[idx];
  } else {
    final Random rand = Random();
    return themes[rand.nextInt(13)];
  }
}

List<dynamic> initTheme() {
  List<dynamic> someTheme = createTheme();
  String appBackground = someTheme[0];
  Color primaryColorLight = someTheme[1];
  Color primaryColor = someTheme[2];
  Color primaryColorDark = someTheme[3];
  return [
    appBackground,
    ThemeData(
        backgroundColor: const Color(0xFFEEEEEE),
        dividerColor: Colors.transparent,
        primarySwatch: Colors.deepOrange,
        primaryColorLight: primaryColorLight,
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        scaffoldBackgroundColor: Colors.transparent,
        unselectedWidgetColor: primaryColor,
        toggleableActiveColor: primaryColorLight,
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
        fontFamily: "Montserrat",
        canvasColor: Colors.transparent,
        textTheme: TextTheme(
            headline6: TextStyle(fontFamily: 'Roboro'),
            bodyText1: TextStyle(
                color: kTextColor, fontWeight: FontWeight.w700, fontSize: 20),
            bodyText2: TextStyle(color: kTextColor)))
  ];
}
