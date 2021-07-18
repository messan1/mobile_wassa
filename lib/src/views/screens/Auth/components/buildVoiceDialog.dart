import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';

import 'closeButtonU.dart';
import 'extendedContainer.dart';
import 'imageLoader.dart';


Future buildVoiceDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  SizeCalculator.height(context, height: .0275))),
          elevation: 0,
          backgroundColor: Colors.black87,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              ExtendedContainer(
                personalizeBorderRadius: BorderRadius.circular(
                    SizeCalculator.height(context, height: .0275)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: SizeCalculator.height(context, height: .289),
                      child:ClipRRect( 
                        borderRadius: BorderRadius.circular(25.0),
                        child: ImageLoader(image: "assets/images/voice.gif",),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  right: SizeCalculator.width(context, width: .085),
                  top: SizeCalculator.height(context, height: .01),
                  child: CloseButtonU(
                    onTap: () {
                       Get.toNamed('/language');
                    },
                  )),
              Positioned(
                  top: SizeCalculator.width(context, width: .54),
                  left: SizeCalculator.height(context, height: .100),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            SizeCalculator.height(context, height: .045),
                        vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: GestureDetector(
                      child: Text(
                        "DESACTIVER",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                      Get.toNamed('/language');
                    },
                    ),
                  ))
            ],
          ),
        );
      });
}
