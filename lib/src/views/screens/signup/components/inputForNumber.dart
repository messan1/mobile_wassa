import 'package:flutter/material.dart';
import 'package:ucolis/src/views/screens/Auth/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/screens/styles/styles.dart';

class InputForNumber extends StatelessWidget {
  const InputForNumber({
    Key key,
    @required this.phone,
  }) : super(key: key);

  final String phone;

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      width: SizeCalculator.width(context, width: .075),
      margin: EdgeInsets.symmetric(
          horizontal: SizeCalculator.width(context, width: .009)),
      height: .045,
      border: Border(bottom: BorderSide(color: blueFont, width: 2)),
      child: Center(
        child: Text(
          phone,
          textAlign: TextAlign.center,
          textScaleFactor: 1.5,
          style: TextStyle(fontWeight: FontWeight.w900, color: blueFont),
        ),
      ),
    );
  }
}
