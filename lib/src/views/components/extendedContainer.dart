import 'package:flutter/material.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';

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
    this.border, this.alignment, this.minHeight,
  }) : super(key: key);
  final Widget child;
  final BoxShape shape;
  final Color color;

  ///height [height] must be a double between 0 and 1
  final double height;
  final double width;
  final double minHeight;
  final List<BoxShadow> boxShadow;
  final LinearGradient linearGradient;
  final DecorationImage image;
  final AlignmentGeometry alignment;

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
    double defaultRadius = SC.height(height);
    return Container(
        alignment: alignment,
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          color: color,
          gradient: linearGradient,
          borderRadius:  personalizeBorderRadius ==null? useBorderRadius == true
              ? BorderRadius.circular(
                  SC.radiusCalculate(defaultRadius),
                )
              : null :  personalizeBorderRadius,
          boxShadow: boxShadow,
          image: image,
          border: border),
      child: child,
    );

  }}