import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:websafe_svg/websafe_svg.dart';
class PaidType extends StatelessWidget {
  const PaidType({
    Key key, this.image, this.paidType, this.sum,
  }) : super(key: key);
  final String image;
  final String paidType;
  final String sum;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      alignment: Alignment.center,
      child: Column(

        children: [
          WebsafeSvg.asset(image, height: 6.5.h),
          SizedBox(height: 1.0.h),
          Text.rich(
            TextSpan(text: paidType, style: TextStyle(color: greyFont, fontWeight: FontWeight.bold), children: [
              TextSpan(text: "\n"+sum, style: TextStyle(color: greyFont, fontWeight: FontWeight.w500, fontSize: 20.0.sp))
            ]),                                   textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
