import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class ButtonWithArrow extends StatefulWidget {
  final IconData arrowDirection;
  final Function onPressed;
  final String title;
  final bool normalCase;
  final bool rotateArrow;
  final AnimationController controller;

  const ButtonWithArrow({Key key, this.arrowDirection, this.onPressed, this.title, this.normalCase, this.rotateArrow, this.controller}) : super(key: key);

  @override
  _ButtonWithArrowState createState() => _ButtonWithArrowState(this.arrowDirection, this.onPressed, this.title, this.normalCase,this.controller);
}

class _ButtonWithArrowState extends State<ButtonWithArrow> with SingleTickerProviderStateMixin{
  final IconData arrowDirection;
  final Function onPressed;
  final String title;
  final bool normalCase;
  final AnimationController controller;
  

  _ButtonWithArrowState(this.arrowDirection, this.onPressed, this.title, this.normalCase,this.controller);
  @override
   Widget build(BuildContext context) {
     final angle = Tween<double>(begin: -pi/2 , end: 0).animate(controller);
    return ExtendedContainer(
      height: 8.5.h,
      color: blackFont,
      personalizeBorderRadius: BorderRadius.circular(SC.radiusCalculate(8.5.h)),
      boxShadow: [
        Styles.backButtonShadow
      ],
      child: MaterialInkWell(
        onPressed: onPressed == null? (){} : onPressed,
        radius: SC.radiusCalculate(8.5.h),
        child: Row(
          children: [
            ExtendedContainer(
              height: 5.5.h,
              width: 5.5.h,
              margin: EdgeInsets.symmetric(horizontal: 3.0.w),
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                Styles.littleShadow
              ],
              child: AnimatedBuilder(
                animation: controller == null? null : controller,
                builder: (BuildContext context, Widget child) { 
                  return Transform.rotate(
                  angle: angle.value,
                  child: MaterialInkWell(
                      onPressed: onPressed == null? (){} : onPressed,
                      customBorder: CircleBorder(),
                      child: Icon(arrowDirection, color: blackFont, size: 3.95.h,)
                      ),
                );
                 },
                
              ),
            ),

            Center(
                child: Text(
                normalCase == true? title:  title.toUpperCase(),
                  style: buttonStyle,
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
  }
}

