import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class SupportOption extends StatelessWidget {
  const SupportOption({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      color: whiteFont,
      personalizeBorderRadius:
          BorderRadius.circular(SC.radiusCalculate(12.0.h)),
      margin: EdgeInsets.symmetric(horizontal: 1.5.w),
      height: 14.5.h,
      boxShadow: [Styles.backButtonShadow],
      child: MaterialInkWell(
        radius: SC.radiusCalculate(12.0.h),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.85.w, vertical: 2.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExtendedContainer(
                alignment: Alignment.center,
                shape: BoxShape.circle,
                color: greyFont.withOpacity(.65),
                width: 5.0.h,
                height: 5.0.h,
                child: Center(
                  child: Icon(
                    icon,
                    color: whiteFont,
                    size: 2.25.h,
                  ),
                ),
              ),
              Text(
                title,
                style: TextStyle(color: blackFont, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
