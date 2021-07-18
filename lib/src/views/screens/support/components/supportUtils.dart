import 'package:flutter/material.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/styles/styles.dart';
class SupportUtils extends StatelessWidget {
  final Function onPressed;
  final String title;
  const SupportUtils({Key key, @required this.onPressed, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      personalizeBorderRadius: BorderRadius.circular(1.5.h),
      margin: EdgeInsets.only(bottom: 1.0.h),
      child: MaterialInkWell(
        onPressed: onPressed,
        radius: 1.5.h,
        child: Padding(
          padding: EdgeInsets.all(1.15.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title),
                  Icon(Icons.arrow_forward_ios_rounded, color: greyFont, size: 2.5.h,),
                ],
              ),
              SizedBox(height: 3),
              Divider(thickness: 1.5,),
            ],
          ),
        ),
      ),
    );
  }
}
