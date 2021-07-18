import 'package:flutter/material.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:progress_indicator_button/button_stagger_animation.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    Key key,
    this.color,
    @required this.title,
    @required this.onTap,
    this.normalCase,
    this.whiteMode,
  }) : super(key: key);
  final Color color;
  final String title;
  final Function onTap;
  final bool normalCase;
  final bool whiteMode;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.0.h,
      child: ProgressButton(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: whiteMode == true ? Colors.white : color ?? blackFont,
        onPressed: onTap,
        child: Center(
            child: Text(
          normalCase == true ? title : title.toUpperCase(),
          style: whiteMode == true
              ? buttonStyle.copyWith(color: blackFont)
              : buttonStyle,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
