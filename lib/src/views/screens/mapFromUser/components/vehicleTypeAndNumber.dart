import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class VehicleTypeAndNumber extends StatelessWidget {
  const VehicleTypeAndNumber({
    Key key, @required this.number, @required this.vehicle,
  }) : super(key: key);
  final String number;
  final String vehicle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ExtendedContainer(
              color: greyFont.withOpacity(.75),
              useBorderRadius: true,
              padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 2.75.w),
              child: Text(number, style: Styles.ucolisGeneralBlackBoldFont,),
            ),
            SizedBox(height: 1.0.h,),
            Text(vehicle, style: Styles.ucolisGeneralBlackBoldFont,)
          ],
        ),
      ],
    );
  }
}
