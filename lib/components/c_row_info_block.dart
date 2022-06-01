import 'package:flutter/material.dart';
import 'package:weather/components/components.dart';
import 'package:weather/size_config.dart';
import 'package:weather/types/types.dart';

class RowInfoBlock extends StatelessWidget {
  final List<dynamic> data;
  const RowInfoBlock({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InfoBlockComponent(
        header: const ['wind.svg', 'Ветер'],
        body: Container(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    IconComponent('chevrons-right.svg'),
                    SizedBox(width: getProportionateScreenHeight(10)),
                    Text(WindSpeed(value: data[0]).toString())
                  ],
                ),
                Row(
                  children: [
                    IconComponent('flat-flag.svg'),
                    SizedBox(width: getProportionateScreenHeight(10)),
                    Text(Angle(value: data[1]).toString())
                  ],
                ),
              ],
            )));
  }
}
