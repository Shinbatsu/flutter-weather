import 'package:flutter/material.dart';
import 'package:weather/size_config.dart';

import 'package:weather/constants.dart';
import 'package:weather/components/components.dart';
import 'package:weather/types/types.dart';

class SliderDailyComponent extends StatelessWidget {
  final List<List<dynamic>> temps;
  const SliderDailyComponent({
    required this.temps,
    Key? key,
  }) : super(key: key);
  String getWeekDay(weekday, offset) {
    return Translated(weekDaysRu[((weekday - 1 + offset) % 7 + 1)]).translate();
  }

  //Translated(weekDaysRu[((now.weekday - 1 + index) % 7 + 1)])
  //    .translate(),
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().toUtc().toLocal();
    final growableList = List<int>.generate(
        6, (int index) => (DateTime.now().add(Duration(days: index)).day),
        growable: true);

    /// Инициализация Адаптивного свойства для этого виджета.
    SizeConfig().init(context);

    /// Поведенческий компонент, расширяется на основе
    /// размеров внутренних виджетов
    return Expanded(

        /// Передаем разделяемый горизонтальный список.
        child: ListView.separated(
      /// Симметричные отступы с каждой стороны.
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(getPadding())),

      /// Эффект инерции во время прокрутки.
      physics: BouncingScrollPhysics(),

      /// Эффект инерции во время прокрутки.
      scrollDirection: Axis.horizontal,

      /// Добавление логики отображения для разделителя.
      separatorBuilder: (context, index) => VerticalDivider(
        color: Colors.transparent,

        /// Адаптивные отступы для ширины.
        width: getProportionateScreenWidth(getPadding()),
      ),
      itemCount: temps.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ParagraphText(
              getWeekDay(now.weekday, index),
            ),
            SizedBox(
              /// Пророрциональное отображение карточки,за
              /// это отвечает [Size Config].
              width: getProportionateScreenWidth(100),
              height: getProportionateScreenWidth(150),
              child: Card(
                color: Colors.black.withOpacity(0.2),

                /// Указание на форму со скруглениями
                shape: RoundedRectangleBorder(
                  /// Скругление отступов у карточки.
                  borderRadius: BorderRadius.circular(getPaddingX2()),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          temps[index][3] > 45
                              ? IconComponent(
                                  'droplets.svg',
                                  size: 20,
                                  color: Color(0xFF158AFF),
                                )
                              : Text(''),
                          SizedBox(width: 10),
                          temps[index][2] > 9
                              ? IconComponent('wind.svg',
                                  size: 20, color: Color(0xFFEACC44))
                              : Text('')
                        ]),
                    IconComponent(temps[index][1] + '.svg',
                        color: Colors.white,
                        size: 45,
                        padding: const [0, 0, 0, 0]),
                    SizedBox(height: 25),
                    Text(Gradus(value: temps[index][0]).asString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        )),
                    SizedBox(height: 10),
                    ParagraphText(
                      growableList[index].toString() +
                          " " +
                          Translated(monthsRu[
                                  growableList[index] < growableList[0]
                                      ? now.add(Duration(days: 30)).month
                                      : now.month])
                              .translate(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ));
  }
}
