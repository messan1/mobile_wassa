import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class SizeCalculator {
  static double radiusCalculate(double shapeSize) {
    return ((10 / 57) * shapeSize) + 2.5;
  }

  static double height(BuildContext context, {double height}) {
    final _orientation = MediaQuery.of(context).orientation;
    if (_orientation == Orientation.portrait) {
      return height == null ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height * height;
    } else {
      return height == null ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * height;
    }
  }

  static double width(BuildContext context, {double width}) {
    final _orientation = MediaQuery.of(context).orientation;
    if (_orientation == Orientation.portrait) {
      return width == null ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * width;
    } else {
      return width == null ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height * width;
    }
  }
}
