import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mediaQuery;
  static late double screenWidth;
  static late double screenHeight;

  static const double baseWidth = 375;
  static const double baseHeight = 812;

  static void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    screenWidth = _mediaQuery.size.width;
    screenHeight = _mediaQuery.size.height;
  }

  static double w(double width) {
    return (width / baseWidth) * screenWidth;
  } 

  static double h(double height) {
    return (height / baseHeight) * screenHeight;
  }

  static double px(double size, {double min = 16.0, double max = 24.0}) {
    double scale = screenWidth / baseWidth;
    return (size * scale).clamp(min, max);
  }

  static bool isTablet() {
    return screenWidth >= 600;
  }

  static SizedBox verticalSpace(double height) {
    return SizedBox(height: h(height));
  }

  static SizedBox horizontalSpace(double width) {
    return SizedBox(width: w(width));
  }

  static EdgeInsets paddingAll(double value) {
    return EdgeInsets.all(w(value));
  }

  static EdgeInsets paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: w(horizontal),
      vertical: h(vertical),
    );
  }
}