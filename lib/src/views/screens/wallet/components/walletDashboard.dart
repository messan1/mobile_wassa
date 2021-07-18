import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/profilePicture.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class WalletDashboard extends StatelessWidget {
  const WalletDashboard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 3.5.h),
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      personalizeBorderRadius: BorderRadius.circular(2.75.h),
      boxShadow: [Styles.backButtonShadow],
      child: Column(
        children: [
          Row(
            children: [
              ProfilePicture(
                profilePicture: null,
                imagePath: null,
                radius: 6.0.h,
                withEditButton: false,
              ),
              SizedBox(
                width: 5.0.w,
              ),
              Text.rich(TextSpan(
                  text: "Yanne",
                  style: TextStyle(
                      color: blackFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0.sp),
                  children: [
                    TextSpan(
                        text: "\n" + "yannsid2@outlook.com",
                        style: TextStyle(
                            color: greyFont,
                            fontWeight: FontWeight.normal,
                            fontSize: 12.0.sp))
                  ]))
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                SizedBox(height: 1.5.h),
                Text(
                  Langue.dispo[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  style: TextStyle(
                      color: greyFont,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.0.sp),
                ),
                SizedBox(height: .85.h),
                Row(
                  children: [
                    Text(
                      "12.500",
                      style: codePromoStyle,
                    ),
                    Spacer(),
                    Text(
                      Langue.wm[Provider.of<VoiceData>(context, listen: false)
                          .langue],
                      style: TextStyle(
                          color: blackFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0.sp),
                    )
                  ],
                ),
                SizedBox(height: 8.0.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}
