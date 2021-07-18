import 'package:flutter/material.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    Key key,
    this.color,
    @required this.title,
    @required this.onTap, this.normalCase, this.whiteMode,
  }) : super(key: key);
  final Color color;
  final String title;
  final Function onTap;
  final bool normalCase;
  final bool whiteMode;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      height: 7.0.h,
      color: whiteMode == true? Colors.white : color ?? Colors.black,
      personalizeBorderRadius: BorderRadius.circular(SC.radiusCalculate(8.5.h)),
      boxShadow: [
        Styles.backButtonShadow
      ],
      child: MaterialInkWell(
        onPressed: onTap,
        radius: SC.radiusCalculate(8.5.h),
        child: Center(
            child: Text(
         normalCase == true? title : title.toUpperCase(),
          style: whiteMode == true? buttonStyle.copyWith(color: blackFont) : buttonStyle,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
