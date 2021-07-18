import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/screens/support/components/faqCard.dart';

class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
      appBarTitle:
          Langue.faq[Provider.of<VoiceData>(context, listen: false).langue],
      activeBackButton: true,
      child: SafeArea(
        child: ListView(
          padding: ConstPadMargin.listViewPadding,
          children: [
            SizedBox(height: 7.5.h),
            FaqCard(
              title: Langue
                  .faq1[Provider.of<VoiceData>(context, listen: false).langue],
              questions: [
                ConstString.faqUnlockAcc,
                ConstString.faqCGG,
                ConstString.faqPhoneNumber
              ],
            ),
            FaqCard(
              title: Langue
                  .faq2[Provider.of<VoiceData>(context, listen: false).langue],
              questions: [
                ConstString.faqPaidM,
                ConstString.faqPrice,
                ConstString.faqDeliveryPrice,
                ConstString.faqHurdlePrice
              ],
            ),
          ],
        ),
      ),
    );
  }
}
