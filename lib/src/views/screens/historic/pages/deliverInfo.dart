import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/screens/historic/components/deliverInformationTab.dart';
import 'package:ucolis/src/views/screens/historic/components/noteCardForDeliver.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class DeliverInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
      activeBackButton: true,
      appBarTitle:
          Langue.info[Provider.of<VoiceData>(context, listen: false).langue],
      child: SafeArea(
          child: ListView(
        children: [
          ExtendedContainer(
            child: Row(
              children: [
                ExtendedContainer(
                  personalizeBorderRadius: BorderRadius.circular(6.75.h),
                  margin: EdgeInsets.symmetric(horizontal: 4.5.w),
                  width: 24.0.w,
                  height: 12.0.h,
                  image: DecorationImage(
                      image: AssetImage("assets/profile.jpg"),
                      fit: BoxFit.fill),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 3.0.h,
                        ),
                        SizedBox(width: 5),
                        Text('4.8',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 12.0.sp))
                      ],
                    ),
                    Text.rich(
                      TextSpan(
                          text: "Messan",
                          style: nameDetailStyle,
                          children: [
                            TextSpan(
                                text: "\nVolkswagen Jetta",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.0.sp))
                          ]),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: NoteCardForDeliver(
                      icon: Icons.star,
                      title: "4.8",
                    )),
                    Expanded(
                        child: NoteCardForDeliver(
                      icon: Icons.star,
                      title: "123",
                    )),
                    Expanded(
                        child: NoteCardForDeliver(
                      icon: Icons.calendar_today,
                      title: "2" +
                          " " +
                          Langue.ans[
                              Provider.of<VoiceData>(context, listen: false)
                                  .langue],
                    )),
                  ],
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                DeliverInformationTab()
              ],
            ),
          )
        ],
      )),
    );
  }
}
