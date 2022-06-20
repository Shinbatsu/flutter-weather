import 'package:flutter/material.dart';
import 'package:weather/components/components.dart';
import 'package:weather/size_config.dart';
import '../components/components.dart';
import 'package:weather/types/types.dart';
import 'package:weather/utils/utils.dart';
import 'package:weather/models/weather_service.dart';

class InfoScreen extends StatefulWidget {
  /// Начальные поля виджета с дополнительной информацией.
  final String appBackground;
  final Future<NextWeather>? weather;
  const InfoScreen({required this.appBackground, this.weather, Key? key})
      : super(key: key);

  /// Синтаксис для указания на состояние.Так принято писать.
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  /// Указываем что в этом объекте позже появится информация о погоде,
  ///  Она будет записана в поле ниже.
  late Future<NextWeather>? weather;

  @override
  void initState() {
    super.initState();
  }

  /// Функция создания графика температур.
  InfoBlockComponent createTempChartBlock({required List<dynamic> data}) {
    return InfoBlockComponent(header: [
      'thermometer-snowflake.svg',
      Translated('Температура').translate()
    ], body: Charts(data: data, unit: '°', startTime: DateTime.now().hour));
  }

  /// Функция создания графика влажности.
  InfoBlockComponent createHumidityChartBlock({required List<dynamic> data}) {
    return InfoBlockComponent(
        header: ['droplet.svg', Translated('Влажность').translate()],
        body: Charts(data: data, unit: '%', startTime: DateTime.now().hour));
  }

  /// Создаем блоки с другой информацией Ветер, Солнце, Координаты
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

  /// Монтируем главный виджет и определяем ниже всю логику
  /// что и как отображать, а что пользователь не увидит.
  @override
  Widget build(BuildContext context) {
    /// Подгружаем новые данные о погоде которые пришли на главный экран.
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    SizeConfig().init(context);
    setState(() {
      weather = arguments['weather'];
    });

    return Scaffold(
      extendBodyBehindAppBar: true,

      /// Отключаем влияние размеров навигации на фон.
      extendBody: true,
      appBar: ExtraAppBarComponent(),
      body: Stack(
        children: [
          ///Размытие фона
          FullBackgroundComponent(
            widget.appBackground,
            withBlur: true,
          ),
          DarkerBackgroundComponent(0.7),

          /// Ассинхронный виджет с инофрмацией о погоде.
          FutureBuilder<NextWeather>(
            future: weather,
            builder: (context, AsyncSnapshot fetched) {
              if (fetched.hasData) {
                List<InfoBlockComponent> infoBlocks = [
                  createTempChartBlock(
                      data: fetched.data!.hourlyTemp
                          .map((value) =>
                              Gradus(value: value).asDouble().toInt())
                          .toList()),
                  createHumidityChartBlock(
                      data: fetched.data!.hourlyHumidity
                          .map((value) =>
                              Humidity(value: value).asDouble().toInt())
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
                              ParagraphText(
                                  fromTimestamp(fetched.data!.sunrise)),
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
                              ParagraphText(
                                  fromTimestamp(fetched.data!.sunset)),
                            ],
                          ),
                        ],
                      )),
                  createRowInfoBlock(
                      data: [fetched.data!.windSpeed, fetched.data!.windDeg]),
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
                          SizedBox(height: 70)
                        ],
                      )),
                ];

                /// Результатом отображения является разделенный список блоков
                /// с информацией о погоде и прочем.
                /// На основе состояние ассинхронных данных мы определяем
                /// что увидит пользователь (предупреждение или информацию).
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
