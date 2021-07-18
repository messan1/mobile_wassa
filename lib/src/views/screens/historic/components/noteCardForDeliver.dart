import 'package:flutter/material.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';
class NoteCardForDeliver extends StatelessWidget {
  const NoteCardForDeliver({
    Key key, @required this.icon, @required this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      alignment: Alignment.center,
      height: 11.0.h,
      margin: EdgeInsets.symmetric(horizontal: 1.5.w),
      border: Border.all(color: greyFont),
      personalizeBorderRadius: BorderRadius.circular(SC.radiusCalculate(12.0.h)),
      color: whiteFont,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ExtendedContainer(
            alignment: Alignment.center,
            shape: BoxShape.circle,
            color: greyFont.withOpacity(.65),
            width: 5.0.h,
            height: 5.0.h,
            child: Center(
              child: Icon(
                icon, color: whiteFont,
                size: 2.25.h,
              ),
            ),
          ),
          Text(title)
        ],
      ),
    );
  }
}
