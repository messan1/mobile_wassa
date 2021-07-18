import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:flutter/material.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class AddPromoCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
        appBarTitle: Langue
            .addPromo[Provider.of<VoiceData>(context, listen: false).langue],
        activeBackButton: true,
        child: SafeArea(
          child: Padding(
            padding: ConstPadMargin.listViewPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                TextField(
                  style: codePromoStyle,
                  textAlign: TextAlign.center,
                  onChanged: (value) {},
                ),
                Spacer(),
                SimpleButton(
                    title: Langue.valider[
                        Provider.of<VoiceData>(context, listen: false).langue],
                    normalCase: true,
                    onTap: () {
                      //Code backend pour le promo
                    }),
                Spacer(),
              ],
            ),
          ),
        ));
  }
}
