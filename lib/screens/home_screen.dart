import 'package:flutter/material.dart';
import 'package:weather/components/components.dart';
import 'package:weather/models/weather_service.dart';
import 'package:weather/size_config.dart';
import 'dart:async';
import 'home_screen_tools.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hive/hive.dart';
import 'package:weather/utils/check_connection.dart';

class HomeScreen extends StatefulWidget {
  final String appBackground;
  const HomeScreen({required this.appBackground, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<NextWeather?> sevenDays;
  late String city;
  String defaultCity = 'Королёв';

  /// Функция инициализации начальных данных погоды.
  void initData() {
    /// Инициализация стандартного города.
    city = defaultCity;

    /// Попытка ролучения погоды.
    sevenDays = fetchWeatherByName(defaultCity);

    /// Проверяем включение настройки последней сессии.
    bool? loadLastSession = Settings.getValue<bool>('key-save-history', false);
    if (loadLastSession) {
      getCityFromStorage().then((value) {
        city = value;
        sevenDays = getWeatherFromStorage();
        setState(() {});
      });
    } else {
      setState(() {});
    }
  }

  /// Часть синтаксиса объявления [StatefulWidget].
  @override
  void initState() {
    initData();
    super.initState();
  }

  /// Отправка асинхронного запроса погоды.
  void sendRequest() async {
    if (!await hasConnection()) {
      /// Показывать оффлайн режим окно-предупреждение.
      showOfflineModeException(context);
      return;
    }

    /// Верификация вводимых данных.
    String? res = await openDialog(context: context);
    if (res == null || res.length < 4|| res==city) {
      return;
    } else {
      /// Если все в порядке, то запросить погоду.
      setState(() {
        city = res;
        sevenDays = fetchWeatherByName(res);
      });
    }
  }

  /// Дополнительная проверка синхронизации с настройками.
  void syncSettings() async {
    /// Загрузка данных из базы данных.
    var box = await Hive.openBox('Storage');
    bool value = box.get('sync');

    /// Если в программе рассинхронизация то синхронизовать различия.
    if (value == false) {
      box.put('sync', true);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Периодически выполняем запрос на синхронизацию настроек.
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      syncSettings();
    });

    /// Периодически выполняем запрос на погоду каждые 30 минут.
    Timer.periodic(Duration(minutes: 30), (Timer t) {
      sevenDays = fetchWeatherByName(city);
      setState(() {});
    });
    SizeConfig().init(context);

    /// Возвращвем холст с виджетами внутри.
    return Scaffold(
      extendBodyBehindAppBar: true,

      /// Отключаем влияние размеров навигации на фон.
      extendBody: true,

      /// Модальное окно не будет двигать фон и другие виджеты.
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          /// Добавлени фона.
          FullBackgroundComponent(widget.appBackground),

          /// Добавлени затемнение для фона.
          DarkerBackgroundComponent(0.4),

          /// Кнопка поиска вверзу слева.
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 35, left: getPadding() / 2),
            child: IconButtonComponent('search.svg', onPressed: sendRequest),
          ),

          /// Ассинхронный виджет Состояние которого зависит от того выполнился
          /// ли ассинхронный запрос.
          FutureBuilder<NextWeather?>(
            ///Ассинхронные данные которые он содержит.
            future: sevenDays,

            /// Фукция отрисовки виджета на основе внутренней логики.
            builder: (context, fetched) {
              if (fetched.hasData) {
                /// Сохраняем данные в бд.
                saveResponse(city, fetched.data!);
                return Column(children: [
                  /// Создание виджета с главной информацией о погоде.
                  Flexible(
                    child: HomeInfoComponent(
                        city: city,
                        temperature: fetched.data!.temp,
                        temperatureMin: fetched.data!.tempMin,
                        temperatureMax: fetched.data!.tempMax,
                        weatherType: fetched.data!.weatherType),
                  ),
                  SizedBox(height: getPadding() * 6),

                  /// Медиа-запрос отрисовка слайдера с погодой на недедю на
                  /// основе высоты экрана.
                  (MediaQuery.of(context).size.height > 640)

                      /// Если высоты достаточно то отрисовать слайдер.
                      ? SliderDailyComponent(
                          temps: List<List<dynamic>>.generate(
                              6, (int index) => fetched.data!.daily[index],
                              growable: true))

                      /// Иначе отрисовать заглушку.
                      : Text('')
                ]);

                /// В случае ошибки вывести экран неверным вводом.
              } else if (fetched.hasError) {
                Future.delayed(Duration(seconds: 4)).then((_) {
                  return CityNotFound(city);
                });
              }

              /// Пока данные не получены будет отрисовываться кружочек загрузки.
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),

      /// Нижняя навигация для открытия других окон.
      bottomNavigationBar: BottomBar(
        /// Передаем в другие окна информацию о погоде.
        weather: sevenDays,
      ),
    );
  }
}
