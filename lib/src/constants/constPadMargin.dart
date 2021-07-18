import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

abstract class ConstPadMargin{
  static EdgeInsetsGeometry get listViewPadding => EdgeInsets.symmetric(horizontal: 8.0.w);
  static EdgeInsetsGeometry get listViewPaddingVH => EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 3.5.h);
  static EdgeInsetsGeometry get talkBoxPadding => EdgeInsets.symmetric(horizontal: 10.0.w);
  static EdgeInsetsGeometry get talkDisableButtonPadding => EdgeInsets.symmetric(horizontal: 27.0.w);
}