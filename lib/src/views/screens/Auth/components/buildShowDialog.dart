import 'package:flutter/material.dart';
import 'package:ucolis/src/views/screens/Auth/components/verticalSeparator.dart';

import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/styles/styles.dart';

import 'closeButtonU.dart';
import 'extendedContainer.dart';
import 'imageLoader.dart';


Future buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizeCalculator.height(context, height: .0275))),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              ExtendedContainer(
                padding: EdgeInsets.all(SizeCalculator.height(context, height: .045)),
                margin: EdgeInsets.symmetric(horizontal: SizeCalculator.width(context, width: .05)),
                personalizeBorderRadius: BorderRadius.circular(SizeCalculator.height(context, height: .0275)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    VerticalSeparator(),
                    Text(
                      "Vos informations ont bien été récues.",
                      style: headerStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeCalculator.height(context, height: .185),
                      child: Center(child: ImageLoader(image: "assets/image4.png")),
                    ),
                    Text(
                      "Vous recevrez un mail au bout de deux (02) heures pour validation.",
                      style: TextStyle(color: greyFont, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Positioned(
                  right: SizeCalculator.width(context, width: .085),
                  top: SizeCalculator.height(context, height: .01),
                  child: CloseButtonU(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/welcome");
                    },
                  ))
            ],
          ),
        );
      });
}
