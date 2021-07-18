import 'package:flutter/material.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/styles/styles.dart';


import 'extendedContainer.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    Key key,
    this.color,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);
  final Color color;
  final String title;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      height: .075,
      color: color ?? blackFont,
      useBorderRadius: true,
      child: Material(
        borderRadius: BorderRadius.circular(SizeCalculator.radiusCalculate(
            SizeCalculator.height(context, height: .099))),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SizeCalculator.radiusCalculate(
              SizeCalculator.height(context, height: .099))),
          onTap: onTap,
          child: Center(
              child: Text(
            title.toUpperCase(),
            style: buttonStyle,
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }
}
