import 'package:flutter/material.dart';
import 'package:weather/size_config.dart';

import 'package:weather/constants.dart';
import 'package:weather/components/components.dart';
import 'package:weather/types/types.dart';

class SliderDailyComponent extends StatelessWidget {
  final List<List<dynamic>> data;
  const SliderDailyComponent({
    required this.data,
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

    SizeConfig().init(context);
    return Expanded(
        child: ListView.separated(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(getPadding())),
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => VerticalDivider(
        color: Colors.transparent,
        width: getProportionateScreenWidth(getPadding()),
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ParagraphText(
              getWeekDay(now.weekday, index),
            ),
            SizedBox(
              width: getProportionateScreenWidth(100),
              height: getProportionateScreenWidth(150),
              child: Card(
                color: Colors.black.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(getPaddingX2()),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          IconComponent(
                            'snowflake.svg',
                            size: 20,
                            color: Color(0xFFFA3E3E),
                          ),
                          SizedBox(width: 10),
                          IconComponent('wind.svg',
                              size: 20, color: Color(0xFFFA3E3E))
                        ]),
                    IconComponent(data[index][1] + '.svg',
                        color: Colors.white,
                        size: 45,
                        padding: const [0, 0, 0, 0]),
                    SizedBox(height: 25),
                    Text(Gradus(value: data[index][0]).asString(),
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
