import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExtendedContainer(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [Styles.backButtonShadow],
        child: MaterialInkWell(
          customBorder: CircleBorder(),
          onPressed: () {
            Get.back();
          },
          child: Center(
            child: Icon(
              GetPlatform.isIOS ?  CupertinoIcons.arrow_left: Icons.arrow_back_ios_rounded,
              color: blackFont,
              size: 2.0.h,
            ),
          ),
        ),
      ),
    );
  }
}
