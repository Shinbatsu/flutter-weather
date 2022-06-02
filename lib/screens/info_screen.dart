import 'package:flutter/material.dart';
import 'package:weather/components/components.dart';
import 'package:weather/size_config.dart';
import '../components/components.dart';
import 'package:weather/types/types.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/weather_service.dart';

class InfoScreen extends StatefulWidget {
  final String appBackground;
  final Future<NextWeather>? weather;
  const InfoScreen({required this.appBackground, this.weather, Key? key})
      : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Future<NextWeather>? weather;

  @override
  void initState() {
    super.initState();
  }

  InfoBlockComponent createTempChartBlock({required List<dynamic> data}) {
    return InfoBlockComponent(header: [
      'thermometer-snowflake.svg',
      Translated('Температура').translate()
    ], body: Charts(data: data));
  }

  InfoBlockComponent createHumidityChartBlock({required List<dynamic> data}) {
    return InfoBlockComponent(
        header: ['droplet.svg', Translated('Влажность').translate()],
        body: Charts(data: data, unit: '%'));
  }

  InfoBlockComponent createRowInfoBlock({required List<num> data}) {
    return InfoBlockComponent(
        header: ['wind.svg', Translated('Ветер').translate()],
        body: Container(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    IconComponent('chevrons-right.svg'),
                    SizedBox(width: 10),
                    Text(WindSpeed(value: data[0]).toString())
                  ],
                ),
                Row(
                  children: [
                    IconComponent('flat-flag.svg'),
                    SizedBox(width: 10),
                    Text(Angle(value: data[1]).toString())
                  ],
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    SizeConfig().init(context);
    setState(() {
      weather = arguments['weather'];
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: ExtraAppBarComponent(),
      body: Stack(
        children: [
          FullBackgroundComponent(
            widget.appBackground,
            withBlur: true,
          ),
          DarkerBackgroundComponent(0.7),
          FutureBuilder<NextWeather>(
            future: weather,
            builder: (context, AsyncSnapshot fetched) {
              if (fetched.hasData) {
                List<InfoBlockComponent> infoBlocks = [
                  InfoBlockComponent(
                      header: [
                        'map-marker.svg',
                        Translated('Расположение').translate()
                      ],
                      body: Column(
                        children: [
                          SizedBox(height: getPadding()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ParagraphText(
                                '${Translated("Широта").translate()}:',
                              ),
                              SizedBox(height: getPadding()),
                              ParagraphText(
                                fetched.data!.lat.toString(),
                              )
                            ],
                          ),
                          SizedBox(height: getPaddingX2()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ParagraphText(
                                '${Translated("Долгота").translate()}:',
                              ),
                              SizedBox(height: getPadding()),
                              ParagraphText(
                                fetched.data!.lon.toString(),
                              )
                            ],
                          ),
                        ],
                      )),
                  createTempChartBlock(
                      data: fetched.data!.hourlyTemp
                          .map((value) =>
                              Gradus(value: value).asDouble().toInt())
                          .toList()),
                  InfoBlockComponent(
                      header: [
                        'sun.svg',
                        Translated('Солнечный цикл').translate()
                      ],
                      body: Column(
                        children: [
                          SizedBox(height: getPadding()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ParagraphText(
                                '${Translated("Закат").translate()}:',
                              ),
                              SizedBox(height: getPadding()),
                              ParagraphText(DateFormat('HH:mm').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                          fetched.data!.sunrise)
                                      .subtract(
                                          Duration(hours: 5, minutes: 37)))),
                            ],
                          ),
                          SizedBox(height: getPaddingX2()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ParagraphText(
                                '${Translated("Восход").translate()}:',
                              ),
                              SizedBox(height: getPadding()),
                              ParagraphText(DateFormat('HH:mm').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      fetched.data!.sunset))),
                            ],
                          ),
                        ],
                      )),
                  createRowInfoBlock(
                      data: [fetched.data!.windSpeed, fetched.data!.windDeg]),
                  createHumidityChartBlock(
                      data: fetched.data!.hourlyHumidity
                          .map((value) =>
                              Humidity(value: value).asDouble().toInt())
                          .toList()),
                ];
                return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => VerticalDivider(
                          color: Colors.transparent,
                          width: getProportionateScreenWidth(10),
                        ),
                    itemCount: infoBlocks.length,
                    itemBuilder: (context, index) {
                      return infoBlocks[index];
                    });
              } else if (fetched.hasError) {
                return Center(child: Text('${fetched.error}'));
              }
              return Text('');
            },
          ),
        ],
      ),
    );
  }
}
