import 'package:flutter/material.dart';
import 'package:weather/components/components.dart';

import 'package:weather/models/combined.dart';
import 'package:weather/size_config.dart';
import 'package:weather/models/weather_models.dart';
import 'dart:async';
import 'package:weather/types/types.dart';
import 'home_screen_tools.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class HomeScreen extends StatefulWidget {
  final String appBackground;
  const HomeScreen({required this.appBackground, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<NextWeather?> sevenDays;
  late String? city;
  String defaultCity = 'Королёв';

  @override
  void initState() {
    city = defaultCity;
    bool loadLastSession = Settings.getValue<bool>('key-save_history', true);
    if (loadLastSession) {
      getCityFromStorage().then((value) {
        if (value != null) {
          city = value;
        } else {}
      });
      sevenDays = getWeatherFromStorage();
    } else {
      sevenDays = fetchAll(city);
    }
    super.initState();
  }

  void sendRequest() async {
    String? res = await openDialog(context: context);
    if (res == null) {
      return;
    } else if (res.length < 4) {
      return;
    } else {
      city = res.toCapitalize();
      sevenDays = fetchAll(res);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 10), (Timer t) {
      syncSettings(setState);
    });
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
                saveWeather(city!, fetched.data!);
                return Column(children: [
                  Flexible(
                    child: HomeInfoComponent(
                        city: city!,
                        temp: Gradus(value: fetched.data!.temp).asString(),
                        tempMin:
                            Gradus(value: fetched.data!.tempMin).asString(),
                        tempMax:
                            Gradus(value: fetched.data!.tempMax).asString(),
                        weatherType: fetched.data!.weatherType),
                  ),
                  SizedBox(height: getPadding() * 6),
                  (MediaQuery.of(context).size.height > 640)
                      ? SliderDailyComponent(
                          data: List<List<dynamic>>.generate(
                              6, (int index) => fetched.data!.daily[index],
                              growable: true))
                      : Text('')
                ]);
              } else if (fetched.hasError) {
                return Center(
                    child: Text(
                  'Город не найден :<',
                  style: TextStyle(fontSize: 40),
                ));
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
