import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class CancelReasonCard extends StatelessWidget {
  const CancelReasonCard({
    Key key,
    @required this.reason,
    @required this.onPressed,
    @required this.value,
    this.onPressedVoid,
  }) : super(key: key);
  final String reason;
  final Function onPressed;
  final Function onPressedVoid;
  final RxBool value;
  @override
  Widget build(BuildContext context) {
    return Obx(() => ExtendedContainer(
          personalizeBorderRadius: BorderRadius.circular(1.5.h),
          margin: EdgeInsets.only(bottom: 1.0.h),
          child: MaterialInkWell(
            onPressed: onPressedVoid,
            radius: 1.5.h,
            child: Padding(
              padding: EdgeInsets.all(.60.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: .75,
                      ),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      Expanded(
                          child: Text(
                        reason,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.ucolisGeneralBlackBoldFont,
                      )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.5.w),
                    child: Divider(
                      thickness: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
