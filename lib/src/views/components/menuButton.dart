import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key key, this.onPressed,
  }) : super(key: key);
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      margin: EdgeInsets.all(8..h),
      padding: EdgeInsets.all(5..h),
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [Styles.backButtonShadow],
      child: Material(
        shape: CircleBorder(),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SC.width()),
          onTap: onPressed?? () {

          },
          child: Icon(
            GetPlatform.isIOS ?  CupertinoIcons.bars: Icons.menu_rounded,
            color: blackFont,
            size: 20..h,
          ),
        ),
      ),
    );
  }
}


