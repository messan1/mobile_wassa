import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class OrderTracker extends StatelessWidget {
  const OrderTracker({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      color: Colors.white,
      width: double.infinity,
      personalizeBorderRadius: BorderRadius.circular(3.5.h),
      padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.5.h),
      child: Column(
        children: [
          Row(
            children: [
              Text(ConstString.endTime, style: Styles.ucolisGeneralBlackBoldFont.copyWith(color: greyFont),),
              Spacer(),
              Text("24 min", style: Styles.ucolisGeneralBlackBoldFont.copyWith(color: blueFont, fontSize: 10.0.sp),),
            ],
          ),
          SizedBox(height: 2.85.h,),
          Row(
            children: [
              Text(ConstString.reservePaidMode, style: Styles.ucolisGeneralBlackBoldFont.copyWith(color: greyFont),),
              Spacer(),
              Icon(Icons.credit_card, color: blackFont, size: 2.5.h,)
            ],
          ),
        ],
      ),
    );
  }
}
