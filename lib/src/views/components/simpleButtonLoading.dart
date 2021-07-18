import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/loadingData.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:progress_state_button/progress_button.dart';

class SimpleButtonLoading extends StatelessWidget {
  const SimpleButtonLoading({
    Key key,
    this.color,
    @required this.title,
    @required this.onTap,
    @required this.state,
    this.normalCase,
    this.whiteMode,
  }) : super(key: key);
  final Color color;
  final String title;
  final Function onTap;
  final ButtonState state;
  final bool normalCase;
  final bool whiteMode;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
        height: 7.0.h,
        personalizeBorderRadius:
            BorderRadius.circular(SC.radiusCalculate(8.5.h)),
        boxShadow: [Styles.backButtonShadow],
        child: ProgressButton(
          stateWidgets: {
            ButtonState.idle: Text(
              normalCase == true ? title : title.toUpperCase(),
              style: whiteMode == true
                  ? buttonStyle.copyWith(color: blackFont)
                  : buttonStyle,
              textAlign: TextAlign.center,
            ),
            ButtonState.loading: Text(
              normalCase == true ? title : title.toUpperCase(),
              style: whiteMode == true
                  ? buttonStyle.copyWith(color: blackFont)
                  : buttonStyle,
              textAlign: TextAlign.center,
            ),
            ButtonState.fail: Text(
              normalCase == true ? title : title.toUpperCase(),
              style: whiteMode == true
                  ? buttonStyle.copyWith(color: blackFont)
                  : buttonStyle,
              textAlign: TextAlign.center,
            ),
            ButtonState.success: Text(
              normalCase == true ? title : title.toUpperCase(),
              style: whiteMode == true
                  ? buttonStyle.copyWith(color: blackFont)
                  : buttonStyle,
              textAlign: TextAlign.center,
            ),
          },
          stateColors: {
            ButtonState.idle: color == null ? blackFont : color,
            ButtonState.loading: color == null ? blackFont : color,
            ButtonState.fail: redFont,
            ButtonState.success: greenFont,
          },
          state: Provider.of<LoadingData>(context, listen: true).stateOnlyText,
          onPressed: onTap,
          padding: EdgeInsets.all(8.0),
        ));
  }
}
