import 'package:flutter/material.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class CloseButtonU extends StatelessWidget {
  const CloseButtonU({
    Key key,
    this.onTap,
  }) : super(key: key);
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      shape: BoxShape.circle,
      color: Colors.white,
      boxShadow: [Styles.backButtonShadow],
      child: MaterialInkWell(
        onPressed: onTap,
        customBorder: CircleBorder(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.close,
              color: blackFont,
              size:2.5.h,
            ),
          ),
        ),
      ),
    );
  }
}
