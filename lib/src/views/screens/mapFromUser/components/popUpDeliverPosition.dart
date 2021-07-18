import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class PopUpDeliverPosition extends StatelessWidget {
  const PopUpDeliverPosition({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: SafeArea(
        child: ExtendedContainer(
          color: Colors.white,
          boxShadow: [Styles.bigBlackShadow],
          margin: EdgeInsets.symmetric(horizontal: 6.5.w),
          personalizeBorderRadius: BorderRadius.only(topLeft: Radius.circular(100.0.h), bottomLeft: Radius.circular(100.0.h), bottomRight: Radius.circular(100.0.h)),
          child: MaterialInkWell(
            personalizeBorderRadius: BorderRadius.only(topLeft: Radius.circular(100.0.h), bottomLeft: Radius.circular(100.0.h), bottomRight: Radius.circular(100.0.h)),
            onPressed: (){
              Get.toNamed("/successDelivery");
            },
            child: Padding(
              padding: EdgeInsets.all(2.35.h),
              child: Row(
                children: [
                  ExtendedContainer(shape: BoxShape.circle, color: blueFont, padding: EdgeInsets.all(.57.h),),
                  SizedBox(width: 2.5.w),
                  Text(ConstString.deliverArrived, style: Styles.ucolisGeneralBlackBoldFont,),
                ],
              ),
            ),
          ),
        ),
      ),
      right: 0,
      left: 0,
      top: 1.0.h,
    );
  }
}
