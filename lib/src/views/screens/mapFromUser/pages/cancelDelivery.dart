import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/screens/mapFromUser/components/cancelReasonCard.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class CancelDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<RxBool> _valueList = List.generate(ConstString.cancelReasonList.length, (index) => false.obs);
    return ScaffoldPlatform(
        activeBackButton: true,
        child: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: ConstPadMargin.listViewPadding,
                children: [
                  SizedBox(height: 5.5.h),
                  Text(
                    ConstString.whyCancelDelivery,
                    style: Styles.ucolisGeneralBlackBoldFont.copyWith(fontSize: 18.0.sp),
                  ),
                  SizedBox(height: 5.5.h),
                  Column(
                    children: List.generate(
                      ConstString.cancelReasonList.length,
                      (index) => CancelReasonCard(
                        reason: ConstString.cancelReasonList[index],
                        value: _valueList[index],
                        onPressed: (bool value) {
                          _valueList[index].toggle();
                        },
                        onPressedVoid: () => _valueList[index].toggle(),
                      ),
                    ),
                  ),
                  SizedBox(height: 13.0.h,),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ExtendedContainer(
                  padding: ConstPadMargin.listViewPadding,
                  alignment: Alignment.center,
                  color: whiteFont,
                  height: 12.0.h,
                  child: SimpleButton(
                    title: "Annuler",
                    normalCase: true,
                    onTap: () {},
                  ),
                ),
              )

            ],
          ),
        ));
  }
}
