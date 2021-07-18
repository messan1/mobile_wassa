import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class PromoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      color: Colors.white,
      personalizeBorderRadius: BorderRadius.circular(3.15.h),
      margin: EdgeInsets.only(bottom: 2.5.h),
      boxShadow: [Styles.backButtonShadow],
      padding: EdgeInsets.all(3.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(
              text: "30" +
                  " % " +
                  Langue.red[
                      Provider.of<VoiceData>(context, listen: false).langue],
              style: TextStyle(fontWeight: FontWeight.bold, color: blackFont),
              children: [
                TextSpan(
                    text: "\n\n" +
                        Langue.date[
                            Provider.of<VoiceData>(context, listen: false)
                                .langue] +
                        " : " +
                        "10/04/2021 à 18h30",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: blackFont,
                        fontSize: 10.0.sp))
              ])),
          SizedBox(
            height: 5.5.h,
          ),
          Stack(
            overflow: Overflow.visible,
            children: [
              _buildCircleCard,
              Positioned(
                child: _buildCircleCard,
                right: -4.5.w,
              ),
              Positioned(
                child: _buildCircleCard,
                right: -9.0.w,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget get _buildCircleCard {
    return ExtendedContainer(
      color: greyFont,
      border: Border.all(color: Colors.grey.shade500.withOpacity(.6)),
      height: 4.5.h,
      width: 4.5.h,
      shape: BoxShape.circle,
    );
  }
}
