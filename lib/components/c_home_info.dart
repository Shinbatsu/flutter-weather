import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/size_config.dart';
import 'package:weather/types/translated_text.dart';

class HomeInfoComponent extends StatelessWidget {
  final String city;
  final String temp;
  final String tempMin;
  final String tempMax;
  final String weatherType;
  const HomeInfoComponent({
    required this.city,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.weatherType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    DateTime date = DateTime.now().toUtc().toLocal();
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: getAppBarPadding()),
            Text(
              city,
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: getPadding()),
            Text(
              date.day.toString() + ", " + date.year.toString(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: getPadding()),
            Text(
              temp,
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(height: getPadding()),
            Container(
                height: 2,
                width: getProportionateScreenWidth(250),
                decoration: BoxDecoration(
                  color: Colors.white,
                )),
            SizedBox(height: getPadding()),
            Text(
              Translated(weatherType).translate(),
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SvgPicture.asset('assets/icons/sun.svg',
                        color: Colors.white,
                        height: 35,
                        width: 35,
                        fit: BoxFit.fill),
                    SizedBox(height: getPadding()),
                    Text(
                      tempMax,
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                ),
                Container(
                    margin: EdgeInsets.all(25),
                    alignment: Alignment.bottomCenter,
                    height: getPaddingX2() * 2,
                    width: 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    )),
                Column(
                  children: [
                    SvgPicture.asset('assets/icons/moon.svg',
                        color: Colors.white,
                        height: 30,
                        width: 30,
                        fit: BoxFit.fill),
                    SizedBox(height: getPadding() * 1.5),
                    Text(
                      tempMin,
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }
}
