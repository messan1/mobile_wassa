import 'package:flutter/material.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/styles/styles.dart';



import 'extendedContainer.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      margin: EdgeInsets.all(SizeCalculator.height(context, height: .01)),
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [Styles.backButtonShadow],
      child: Material(
        shape: StadiumBorder(),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SizeCalculator.width(context)),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: blackFont,
            size: SizeCalculator.height(context, height: .025),
          ),
        ),
      ),
    );
  }
}
