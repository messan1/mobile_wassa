import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class SC {
  static double radiusCalculate(double shapeSize) {
    return ((10 / 57) * shapeSize) + 2.5;
  }

  static double height([double height]) {
    final _orientation = Get.context.orientation;
    if (_orientation == Orientation.portrait) {
      return height == null ? Get.context.height : Get.context.height * height;
    } else {
      return height == null ? Get.context.width : Get.context.width * height;
    }
  }

  static double width([double width]) {
    final _orientation = Get.context.orientation;
    if (_orientation == Orientation.portrait) {
      return width == null ? Get.context.width : Get.context.width * width;
    } else {
      return width == null ? Get.context.height : Get.context.height * width;
    }
  }
}
