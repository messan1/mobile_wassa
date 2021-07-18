import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
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
import 'package:ucolis/src/views/screens/support/components/supportOption.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
      activeBackButton: true,
      appBarTitle:
          Langue.sup3[Provider.of<VoiceData>(context, listen: false).langue],
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
                //SupportUtilsTab(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: SupportOption(
                            icon: Icons.call,
                            title: Langue.contact1[
                                Provider.of<VoiceData>(context, listen: false)
                                    .langue],
                            onPressed: () {
                              //CALL
                            },
                          )),
                          Expanded(
                              child: SupportOption(
                                  icon: Icons.mail,
                                  title: Langue.contact2[Provider.of<VoiceData>(
                                          context,
                                          listen: false)
                                      .langue],
                                  onPressed: () {
                                    //SEND EMAIL
                                  })),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
