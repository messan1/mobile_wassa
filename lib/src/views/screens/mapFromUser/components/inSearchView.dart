import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:websafe_svg/websafe_svg.dart';

class InSearchView extends StatelessWidget {
  const InSearchView({
    Key key,
    @required String vehicle,
  }) : _vehicle = vehicle,  super(key: key);

  final String _vehicle;
  static get _motor => "motor";

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: ExtendedContainer(
          padding: EdgeInsets.symmetric(horizontal: 5.5.w),
          color: blackFont.withOpacity(.75),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 5.5.h,
                ),
                Stack(
                  children: [
                    SpinKitDoubleBounce(
                      color: greyFont,
                      size: 30.0.h,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: ExtendedContainer(
                          child: WebsafeSvg.asset(_vehicle.toLowerCase().contains(_motor)? "assets/icon/motor.svg" : "assets/icon/cars.svg", height: 4.5.h),
                          padding: EdgeInsets.all(4.5.h),
                          shape: BoxShape.circle,
                          color: greyFont.withOpacity(.55),
                        ),
                      ),
                    ),
                  ],
                ),
                ExtendedContainer(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 5.5.h),
                  child: Text(
                    ConstString.deliverSearching,
                    style: Styles.ucolisGeneralBlackBoldFont.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
