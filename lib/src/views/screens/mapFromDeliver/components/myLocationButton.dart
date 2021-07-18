import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class MyLocationButton extends StatelessWidget {
  const MyLocationButton({
    Key key, @required this.onPressed,
  }) : super(key: key);

  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialInkWell(
      customBorder: CircleBorder(),
      onPressed: onPressed,
      child: ExtendedContainer(
        color: Colors.white,
        shape: BoxShape.circle,
        child: Padding(
          padding: EdgeInsets.all(2.5.h),
          child: Center(
            child: Icon(
              Icons.my_location_outlined, color: blackFont,
            ),
          ),
        ),
      ),
    );
  }
}
