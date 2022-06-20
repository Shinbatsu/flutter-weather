import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather/size_config.dart';

class _BarData {
  final double value;

  const _BarData(this.value);
}

/// Начальные данные для графиков.
class Charts extends StatefulWidget {
  final List<dynamic> data;
  final String unit;
  final int startTime;
  const Charts(
      {Key? key,
      required this.unit,
      required this.data,
      required this.startTime})
      : super(key: key);
  @override
  State<Charts> createState() => _ChartsState();
}

/// Поведенческий под-компонент для регулироная логики отрисовки.
class _ChartsState extends State<Charts> {
  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
  ) {
    return BarChartGroupData(
      showingTooltipIndicators: [0],
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: getProportionateScreenWidth(10),
        ),
      ],
    );
  }

  /// Адаптер для конвертации из данных в объекты столбчатых диаграмм.
  List<_BarData> createBars() {
    return widget.data.map((value) => _BarData(value.toDouble())).toList();
  }

  /// Функция расчета минимума для отображения.
  int getMin() {
    return widget.data.reduce((curr, next) => curr < next ? curr : next);
  }

  /// Функция расчета максимума для отображения.
  int getMax() {
    return widget.data.reduce((curr, next) => curr > next ? curr : next);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
        width: getProportionateScreenWidth(1200),
        height: getProportionateScreenWidth(200),
        child: ListView.separated(

            /// Добавление поведения для при прокрутки "Инерционной замедление"
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => VerticalDivider(
                  color: Colors.transparent,
                  width: 20,
                ),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                width: getProportionateScreenWidth(900),
                height: getProportionateScreenWidth(200),

                /// Отступы для корректного отображения краев.
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: BarChart(
                  BarChartData(
                      alignment: BarChartAlignment.spaceBetween,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        show: true,
                        leftTitles: AxisTitles(
                          drawBehindEverything: true,
                        ),
                        rightTitles: AxisTitles(
                          drawBehindEverything: true,
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    ((index + widget.startTime) % 24)
                                            .toString() +
                                        ':00',
                                    style: TextStyle(color: Colors.white)),
                              );
                            },
                          ),
                        ),
                      ),

                      /// Отключение сетки.
                      gridData: FlGridData(
                        show: false,
                      ),

                      /// Добавление данных к отображению.
                      barGroups: createBars().asMap().entries.map((e) {
                        final index = e.key;
                        final data = e.value;
                        return generateBarGroup(index,
                            Theme.of(context).primaryColorLight, data.value);
                      }).toList(),
                      minY: getMin().toDouble() - getMin().toDouble() * 0.3,
                      maxY: getMax().toDouble() + getMax().toDouble() * 0.3,
                      barTouchData: BarTouchData(
                        enabled: true,

                        /// С каких сторон и что отображать.
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.transparent,
                          getTooltipItem: (
                            BarChartGroupData group,
                            int groupIndex,
                            BarChartRodData rod,
                            int rodIndex,
                          ) {
                            /// Подготовка и Серилизация данных:
                            /// "Округление чисел".
                            return BarTooltipItem(
                              rod.toY.round().toString() + widget.unit,
                              const TextStyle(
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      )),
                ),
              );
            }));
  }
}
