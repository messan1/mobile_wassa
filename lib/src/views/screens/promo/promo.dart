import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:flutter/material.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/screens/promo/components/promoCard.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class Promo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
      appBarIconColor: Colors.black,
      activeBackButton: true,
      appBarTitle:
          Langue.promo[Provider.of<VoiceData>(context, listen: false).langue],
      child: SafeArea(
          child: Stack(
        children: [
          ListView(
            padding: ConstPadMargin.listViewPadding,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 3.5.h,
                  ),
                  PromoCard(),
                  PromoCard(),
                ],
              ),
              SizedBox(height: 13.95.h)
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ExtendedContainer(
              padding: ConstPadMargin.listViewPadding,
              alignment: Alignment.center,
              color: whiteFont,
              height: 12.95.h,
              child: SimpleButton(
                title: Langue.addPromo[
                    Provider.of<VoiceData>(context, listen: false).langue],
                normalCase: true,
                onTap: () {
                  Get.toNamed("/addPromoCode");
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}
