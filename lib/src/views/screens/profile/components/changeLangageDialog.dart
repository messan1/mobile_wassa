import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/closeButtonU.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ChangeLangageDialog extends StatefulWidget {
  const ChangeLangageDialog({
    Key key,
  }) : super(key: key);

  @override
  _ChangeLangageDialog createState() => _ChangeLangageDialog();
}

class _ChangeLangageDialog extends State<ChangeLangageDialog> {

  RxDouble _bottom = 5.0.h.obs;

  @override
  void initState() {

    Future.delayed(Duration(milliseconds: 500)).then((value){
      _bottom.value = 40.0.h;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          height: 40.0.h,
          width: 80.0.w,
          child: Container(
            color: Colors.greenAccent,
          ),
        )
        ),
    );
  }
}
