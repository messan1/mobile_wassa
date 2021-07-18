import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ServiceButton extends StatelessWidget {
  const ServiceButton({
    Key key, @required this.title, @required this.image, @required this.onPressed,
  }) : super(key: key);
  final String title;
  final String image;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(
      children: [
        ExtendedContainer(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 30..w, vertical: 10..h),
          personalizeBorderRadius: BorderRadius.circular(18..h),
          color: Colors.white,
          boxShadow: [
            Styles.backButtonShadow
          ],
          child: MaterialInkWell(
              onPressed: onPressed == null? (){

              } : onPressed,
              radius: 18..h,
              child: Padding(
                padding: EdgeInsets.symmetric( vertical: 4.5.h),
                child: Center(child: WebsafeSvg.asset(image, height: 50..h)),
              )),

        ),
        Text(title.toUpperCase(), style: menuHomeStyle,)
      ],
    ));
  }
}
