import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/chooseAdressData.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/screens/dashboard/components/timeIndicator.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:websafe_svg/websafe_svg.dart';

class PackageType extends StatelessWidget {
  PackageType({
    Key key, this.selected, this.onPressed, this.group, @required this.vehicle,
  }) : super(key: key);
  final int selected;
  final RxInt group;
  final Function onPressed;
  final String vehicle;

  static get _motor => "motor";

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Opacity(
      opacity: selected != group.value ? .45 : 1.0 ,
      child: ExtendedContainer(
        border: Border.all(color: selected != group.value ? Colors.transparent:blueFont),
        color: Colors.white,
        personalizeBorderRadius: BorderRadius.circular(2.5.h),
        margin: EdgeInsets.symmetric(horizontal: 2.5.w),
        boxShadow: [
          Styles.littleShadow
        ],
        alignment: Alignment.center,
        child: MaterialInkWell(
          onPressed: onPressed,
          radius: 2.5.h,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.75.h, horizontal: 9.5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: 6.95.h,
                        maxWidth: 7.95.h
                      ),
                        child: WebsafeSvg.asset(data[selected]['image'], height: 6.95.h)),
                    timeIndicator(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

}
