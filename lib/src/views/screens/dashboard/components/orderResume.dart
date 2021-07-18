import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/walletMoneyViewer.dart';
import 'package:ucolis/src/views/screens/dashboard/components/timeIndicator.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:websafe_svg/websafe_svg.dart';

class OrderResume extends StatelessWidget {
  const OrderResume({
    Key key,
    this.vehicle = "motor",
  }) : super(key: key);
  final String vehicle;

  static get _motor => "motor";

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Positioned(
            bottom: -.75.h,
            left: 0,
            right: 0,
            child: ExtendedContainer(
              height: 5.5.h,
              color: Colors.white.withOpacity(.85),
              personalizeBorderRadius: BorderRadius.circular(3.5.h),
              boxShadow: [Styles.backButtonShadow],
              margin: EdgeInsets.symmetric(horizontal: 6.0.w),
              padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.5.h),
            ),
          ),
          ExtendedContainer(
            color: Colors.white,
            width: double.infinity,
            personalizeBorderRadius: BorderRadius.circular(3.5.h),
            padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.5.h),
            boxShadow: [Styles.backButtonShadow],
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 4.5.w),
                          child: WebsafeSvg.asset(
                              vehicle.toLowerCase().contains(_motor)
                                  ? "assets/icon/motor.svg"
                                  : "assets/icon/cars.svg",
                              height: 5.5.h),
                        ),
                        Text(
                          "*5",
                          style: Styles.ucolisGeneralBlackBoldFont,
                        )
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 3.95.w),
                      child: WalletMoneyViewer(
                        price: "5000",
                      ),
                    )
                  ],
                ),
                SizedBox(height: 2.5.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Text(
                      vehicle.toLowerCase().contains(_motor)
                          ? "Petit colis"
                          : "Standard",
                      style: Styles.ucolisGeneralBlackBoldFont,
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 1.35.w),
                      child: timeIndicator(useVerticalMargin: false),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
