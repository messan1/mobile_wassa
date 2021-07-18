import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';

Widget timeIndicator({bool useVerticalMargin}) {
  return ExtendedContainer(
    color: blackFont,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(vertical: .35.h, horizontal: 2.56.w),
    margin: EdgeInsets.only(top: useVerticalMargin == false ? 0 : 5.5.h),
    useBorderRadius: true,
    child: Center(
        child: Text(
      "30 min",
      style: Styles.ucolisGeneralBlackBoldFont
          .copyWith(color: whiteFont, fontSize: 9.0.sp),
    )),
  );
}
