import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:websafe_svg/websafe_svg.dart';

class PaidModeCard extends StatelessWidget {
  const PaidModeCard({
    Key key, @required this.image, @required this.onPressed, @required this.title,
  }) : super(key: key);
  final String image;
  final String title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      color: Colors.white,
      personalizeBorderRadius: BorderRadius.circular(2.5.h),
      boxShadow: [
        Styles.backButtonShadow
      ],
      child: MaterialInkWell(
        radius:2.85.h,
        onPressed: onPressed,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WebsafeSvg.asset(image, height: 7.5.h),
              SizedBox(height: 1.5.h,),
              Flexible(child: Text(title, style: Styles.ucolisGeneralBlackBoldFont.copyWith(fontSize: 11.5.sp, fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis,))
            ],
          ),
        ),
      ),
    );
  }
}
