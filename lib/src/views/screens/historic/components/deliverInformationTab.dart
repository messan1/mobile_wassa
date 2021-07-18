import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class DeliverInformationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      border: Border.all(color: greyFont),
      personalizeBorderRadius: BorderRadius.circular(3.5.h),
      color: whiteFont,
      padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, top: 3.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _informationField(
              title: Langue.cours1[
                  Provider.of<VoiceData>(context, listen: false).langue],
              contain: "16.06.2017"),
          _informationField(
              title: Langue.cours2[
                  Provider.of<VoiceData>(context, listen: false).langue],
              contain: "Van"),
          _informationField(
              title: Langue.cours3[
                  Provider.of<VoiceData>(context, listen: false).langue],
              contain: "HS728K"),
          _informationField(
              title: Langue.cours4[
                  Provider.of<VoiceData>(context, listen: false).langue],
              contain: "HS728K",
              divider: false),
        ],
      ),
    );
  }

  Widget _informationField(
      {@required String title, @required String contain, bool divider}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(
              text: title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: greyFont.withOpacity(.5)),
              children: [
                TextSpan(
                    text: "\n$contain",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: blackFont))
              ])),
          SizedBox(height: 4),
          divider == false
              ? Container()
              : Divider(
                  thickness: 1.35,
                ),
        ],
      ),
    );
  }
}
