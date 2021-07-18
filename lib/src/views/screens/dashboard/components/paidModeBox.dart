import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/closeButtonU.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/dashboard/components/paidModeCard.dart';

class PaidModeBox extends StatelessWidget {
  const PaidModeBox({
    Key key, this.vehicle,
  }) : super(key: key);
final String vehicle;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExtendedContainer(
          height: 70.0.h,
          color: Colors.transparent,
          child: Center(
            child: ExtendedContainer(
              margin: ConstPadMargin.talkBoxPadding,
              color: Colors.white,
              width: double.infinity,
              height: 50.0.h,
              personalizeBorderRadius: BorderRadius.circular(SC.radiusCalculate(15.0.h)),
              padding: EdgeInsets.all(1.15.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      CloseButtonU(onTap: (){Get.back();},)
                    ],
                  ),
                  Expanded(child: Center(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 11.5.h, horizontal: 1.5.w),
                      child: Row(
                        children: [
                          Expanded(child: PaidModeCard(image: "assets/icon/motor.svg", title: "CASH", onPressed:(){Get.toNamed("/map", arguments: vehicle)?.then((value){
                            Get.back();
                          });})),
                          SizedBox(width: 3.5.w,),
                          Expanded(child: PaidModeCard(image: "assets/icon/motor.svg", title: "MON COMPTE", onPressed:(){Get.toNamed("/map", arguments: vehicle)?.then((value){
                            Get.back();
                          });})),
                        ],
                      ),
                    ),
                  )),
                  SizedBox(height: 2.5.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
