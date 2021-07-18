import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/support/components/supportUtils.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class SupportUtilsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: ExtendedContainer(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 3.5.h),
          personalizeBorderRadius: BorderRadius.circular(2.75.h),
          boxShadow: [Styles.backButtonShadow],
          child: Padding(
            padding: EdgeInsets.all(4.5.w),
            child: Column(
              children: [
                SizedBox(
                  height: 1.0.h,
                ),
                SupportUtils(
                    title: Langue.ticket[
                            Provider.of<VoiceData>(context, listen: false)
                                .langue] +
                        " " +
                        "1" +
                        " : " +
                        "WASSAXCFCTC3Z45R",
                    onPressed: () {
                      print("Ticket 1");
                    }),
                SupportUtils(
                    title: Langue.ticket[
                            Provider.of<VoiceData>(context, listen: false)
                                .langue] +
                        " " +
                        "2" +
                        " : " +
                        "WASSAXCFC4C3Z45R",
                    onPressed: () {
                      print("Ticket 2");
                    }),
                SupportUtils(
                    title: Langue.ticket[
                            Provider.of<VoiceData>(context, listen: false)
                                .langue] +
                        " " +
                        "3" +
                        " : " +
                        "WASSAXZFCTC3Z45R",
                    onPressed: () {
                      print("Ticket 3");
                    }),
              ],
            ),
          )),
    );
  }
}
