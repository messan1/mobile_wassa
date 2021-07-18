import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class RechargeOperatorCard extends StatelessWidget {
  const RechargeOperatorCard({
    Key key, @required this.color, @required this.operator, @required this.onPressed,
  }) : super(key: key);
  final Color color;
  final String operator;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      personalizeBorderRadius: BorderRadius.circular(2.0.h),
      margin: EdgeInsets.symmetric(vertical: 1.0.h),
      color: Colors.white,
      boxShadow: [
        Styles.littleShadow
      ],
      child: MaterialInkWell(
        radius: 2.0.h,
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.all(2.0.h),
          child: Row(
            children: [
              ExtendedContainer(
                height: 5.0.h,
                width: 5.0.h,
                color: color,
                personalizeBorderRadius: BorderRadius.circular(SC.radiusCalculate(5.0.h)),
              ),
              SizedBox(width: 5.0.w,),
              Expanded(child: Row(
                children: [
                  Text(operator, style: TextStyle(color: blackFont, fontWeight: FontWeight.w700, fontSize: 14.0.sp),), Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded, color: greyFont, size: 2.75.h,)
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
