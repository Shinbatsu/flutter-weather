import 'package:flutter/material.dart';
import 'package:weather/components/components.dart';
import 'package:weather/size_config.dart';
import 'package:weather/types/translated_text.dart';
import 'package:weather/services/notifyer.dart';
import 'package:timezone/data/latest.dart' as tz;

class AboutScreen extends StatelessWidget {
  final String appBackground;

  const AboutScreen({required this.appBackground, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    tz.initializeTimeZones();
    SizeConfig().init(context);
    List<Widget> aboutBlocks = [
      Column(children: [
        InfoBlockComponent(
            header: ['map.svg', Translated('Информация').translate()],
            body: Container(
              padding: EdgeInsets.all(getPadding()),
              child: HeaderText(
                Translated(
                        'Данное приложение разрабатывалось в учебных целях и является дипломным проектом, разработка велась внутри команды из двух человек, каждый из которых отвечал за определенную часть приложения, все данные взяты из открытых источников.')
                    .translate(),
              ),
            )),
        InfoBlockComponent(
            header: ['user.svg', Translated('Разработчики').translate()],
            body: Container(
                padding: EdgeInsets.all(getPadding()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HeaderText(
                            '${Translated("Дизайн и Интерфейс").translate()} (UI):',
                          ),
                          SizedBox(height: getPadding()),
                          ParagraphText(
                            Translated('Матвей Купцов (SparkieAG)').translate(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getPaddingX2(),
                    ),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HeaderText(
                            '${Translated("Логика Работы").translate()} (API):',
                          ),
                          SizedBox(height: getPadding()),
                          ParagraphText(
                            Translated('Юрий Васькевич (LinerS)').translate(),
                          )
                        ],
                      ),
                    ),
                  ],
                ))),
      ]),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ExtraAppBarComponent(),
      body: Stack(children: [
        FullBackgroundComponent(
          appBackground,
          withBlur: true,
        ),
        DarkerBackgroundComponent(0.7),
        Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: List<int>.generate(1, (i) => i)
                    .map((i) => aboutBlocks[i])
                    .toList(),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20, left: 20),
              child: ParagraphText(
                'Version: 1.1.12',
              ),
            ),
          ],
        ),
        Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: 30, bottom: 30),
            child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.message,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await NotificationService().showNotification(
                      id: 0,
                      title: 'Tenki Погода',
                      body: 'Простая демонстрация сервиса уведомлений :)');
                }))
      ]),
    );
  }
}
