import 'package:flutter/material.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';

class VerticalSeparator extends StatelessWidget {
  const VerticalSeparator({
    Key key,
    this.height,
  }) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: SizeCalculator.height(context, height: height ?? .035));
  }
}
