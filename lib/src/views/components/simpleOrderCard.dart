import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class SimpleOrderCard extends StatelessWidget {
  const SimpleOrderCard({
    Key key, @required this.endTime, @required this.beginTime, @required this.startingPoint, @required this.deliveryPoint, this.useShadowBox,
  }) : super(key: key);
  final String endTime;
  final String beginTime;
  final String startingPoint;
  final String deliveryPoint;
  final bool useShadowBox;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 3.5.h),
      border: useShadowBox!=false? Border.fromBorderSide(BorderSide.none) : Border.all(color: blackFont.withOpacity(.15)),
      personalizeBorderRadius: BorderRadius.circular(2.75.h),
      boxShadow: useShadowBox != false? [Styles.backButtonShadow] : [],
      child: Padding(
        padding: EdgeInsets.all(4.5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(height: 5),
            Row(
              children: [
                ExtendedContainer(
                  height: 12.85.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(beginTime),
                      Text(endTime),
                    ],
                  ),
                ),
                SizedBox(
                  width: 1.5.w,
                ),
                Column(
                  children: [
                    ExtendedContainer(
                      color: blackFont,
                      height: 1.0.h,
                      width: 1.0.h,
                      shape: BoxShape.circle,
                    ),
                    ExtendedContainer(
                      height: 10.5.h,
                      width: .5.w,
                      color: blackFont,
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.arrow_drop_down_sharp,
                        color: blackFont,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 1.5.w,
                ),
                Expanded(
                  child: ExtendedContainer(
                    height: 12.85.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ExtendedContainer(
                          child: Text(
                            startingPoint,
                            style: Styles.ucolisGeneralBlackBoldFont,
                          ),
                        ),
                        ExtendedContainer(
                          child: Text(
                            deliveryPoint,
                            style: Styles.ucolisGeneralBlackBoldFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.5.h,
            ),
          ],
        ),
      ),
    );
  }
}

