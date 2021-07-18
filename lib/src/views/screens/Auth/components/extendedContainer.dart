import 'package:flutter/material.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';

class ExtendedContainer extends StatelessWidget {
  const ExtendedContainer({
    Key key,
    this.shape,
    this.color,
    this.height,
    this.width,
    this.boxShadow,
    this.linearGradient,
    this.image,
    this.padding,
    this.margin,
    this.useBorderRadius,
    this.personalizeBorderRadius,
    this.child,
    this.border,
  }) : super(key: key);
  final Widget child;
  final BoxShape shape;
  final Color color;

  ///height [height] must be a double between 0 and 1
  final double height;
  final double width;
  final List<BoxShadow> boxShadow;
  final LinearGradient linearGradient;
  final DecorationImage image;

  ///ExtendedContainer can generate default border radius based on iOS guidelines design
  ///to use it, [useBorderRadius] must have [true] value. It's [false] by default.
  ///If you want to personalize the border radius user [personalizeBorderRadius].
  final bool useBorderRadius;
  final BorderRadius personalizeBorderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Border border;
  @override
  Widget build(BuildContext context) {
    double defaultRadius = SizeCalculator.height(context, height: height);
    return Container(
      height: height != null
          ? SizeCalculator.height(context, height: height)
          : null,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          color: color ?? Colors.white,
          borderRadius: useBorderRadius == true
              ? BorderRadius.circular(
                  SizeCalculator.radiusCalculate(defaultRadius),
                )
              : personalizeBorderRadius ?? null,
          boxShadow: boxShadow,
          image: image,
          border: border),
      child: child,
    );
  }
}
