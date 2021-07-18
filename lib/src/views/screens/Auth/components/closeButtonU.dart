import 'package:flutter/material.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/styles/styles.dart';


import 'extendedContainer.dart';


class CloseButtonU extends StatelessWidget {
  const CloseButtonU({
    Key key,
    this.onTap,
  }) : super(key: key);
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      shape: BoxShape.circle,
      boxShadow: [Styles.backButtonShadow],
      padding: EdgeInsets.all(SizeCalculator.height(context, height: .015)),
      child: Material(
        shape: StadiumBorder(),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SizeCalculator.width(context)),
          onTap: onTap,
          child: Icon(
            Icons.close,
            color: blackFont,
            size: SizeCalculator.height(context, height: .025),
          ),
        ),
      ),
    );
  }
}
