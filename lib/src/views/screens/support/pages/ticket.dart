import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/styles/styles.dart';
import 'package:ucolis/src/views/screens/support/components/faqCard.dart';
import 'package:ucolis/src/views/screens/support/components/supportUtilsCard.dart';

class Ticket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
      activeBackButton: true,
      appBarTitle:
          Langue.sup2[Provider.of<VoiceData>(context, listen: false).langue],
      titleColor: whiteFont,
      child: Stack(
        children: [
          ExtendedContainer(
            height: 40.5.h,
            color: blackFont,
          ),
          SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 20.0.h,
                ),
                SupportUtilsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
