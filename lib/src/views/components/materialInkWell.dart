import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MaterialInkWell extends StatelessWidget {
  const MaterialInkWell({
    Key key, @required this.onPressed, this.radius, this.customBorder, @required this.child, this.personalizeBorderRadius,
  }) : super(key: key);
  final Function onPressed;
  final double radius;
  final BorderRadius personalizeBorderRadius;
  final ShapeBorder customBorder;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: customBorder,
      borderRadius: customBorder == null? personalizeBorderRadius == null? BorderRadius.circular(radius) : personalizeBorderRadius: null,
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: customBorder == null? personalizeBorderRadius == null? BorderRadius.circular(radius) : personalizeBorderRadius: null,

        customBorder: customBorder,
        child: child,
      ),
    );
  }
}
