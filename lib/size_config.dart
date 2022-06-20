import 'package:flutter/material.dart';

/// Класс адаптивного масштабирования виджетов
class SizeConfig {
  /// Ассинхронное объявление запроса на размеры устройства
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

/// Функция адаптивного расчета высоты на основе
/// макетной высоты в дизайне [780px].
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 780.0) * screenHeight;
}

/// Функция адаптивного расчета Ширины на основе
/// макетной ширины в дизайне [320px].
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 320.0) * screenWidth;
}

/// Стандартный Padding, нужен для стандартизации отступов.
double getPadding() {
  return 10;
}

/// Двойной Padding, нужен для стандартизации отступов.
double getPaddingX2() {
  return 20;
}

/// Размер в пикселах, шрифт текста.
double getParagraph() {
  return 16;
}

/// Размер в пикселах, шрифт заголовков текста.
double getHeader() {
  return 20;
}

/// Размер в пикселах, отступ для AppBar
double getAppBarPadding() {
  return 80;
}

/// Размер в пикселах, размер иконки.
double getAppIconSize() {
  return 20;
}
