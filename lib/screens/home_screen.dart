import 'package:flutter/material.dart';
import 'package:weather/components/components.dart';
import 'package:weather/models/weather_service.dart';
import 'package:weather/size_config.dart';
import 'dart:async';
import 'home_screen_tools.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hive/hive.dart';

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
  void initData() {
    city = defaultCity;
    bool loadLastSession = Settings.getValue<bool>('key-save_history', true);
    if (loadLastSession) {
      getCityFromStorage().then((value) {
        if (value != null) {
          city = value;
        }
      });
      sevenDays = getWeatherFromStorage();
    } else {
      sevenDays = fetchWeatherByName(defaultCity);
    }
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  void sendRequest() async {
    String? res = await openDialog(context: context);
    if (res == null || res.length < 4) {
      return;
    } else {
      setState(() {
        city = res;
        sevenDays = fetchWeatherByName(res);
      });
    }
  }

  void syncSettings() async {
    var box = await Hive.openBox('Storage');
    bool value = box.get('sync');
    if (value == false) {
      box.put('sync', true);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      syncSettings();
    });
    //Timer.periodic(Duration(minutes: 10), (Timer t) {
    //  sevenDays = fetchWeatherByName(city);
    //});//TODO UNLOCK AT RELEASE
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          FullBackgroundComponent(widget.appBackground),
          DarkerBackgroundComponent(0.4),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 35, left: getPadding() / 2),
            child: IconButtonComponent('search.svg', onPressed: sendRequest),
          ),
          FutureBuilder<NextWeather?>(
            future: sevenDays,
            builder: (context, fetched) {
              if (fetched.hasData) {
                saveResponse(city, fetched.data!);
                return Column(children: [
                  Flexible(
                    child: HomeInfoComponent(
                        city: city,
                        temperature: fetched.data!.temp,
                        temperatureMin: fetched.data!.tempMin,
                        temperatureMax: fetched.data!.tempMax,
                        weatherType: fetched.data!.weatherType),
                  ),
                  SizedBox(height: getPadding() * 6),
                  (MediaQuery.of(context).size.height > 640)
                      ? SliderDailyComponent(
                          temps: List<List<dynamic>>.generate(
                              6, (int index) => fetched.data!.daily[index],
                              growable: true))
                      : Text('')
                ]);
              } else if (fetched.hasError) {
                return CityNotFound(city);
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(
        weather: sevenDays,
      ),
    );
  }
}
