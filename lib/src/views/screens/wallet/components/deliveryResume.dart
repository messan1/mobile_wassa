import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class DeliveryResume extends StatelessWidget {
  const DeliveryResume({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              Langue
                  .today[Provider.of<VoiceData>(context, listen: false).langue],
              style: TextStyle(
                  color: violetFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0.sp),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: violetFont,
              size: 3.45.h,
            )
          ],
        ),
        Divider(),
        SizedBox(height: 2),
        Row(
          children: [
            Text(
              Langue.liv[Provider.of<VoiceData>(context, listen: false).langue],
              style: TextStyle(
                  color: violetFont,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0.sp),
            ),
            Spacer(),
            Text("-800" + " FCFA",
                style: TextStyle(
                    color: redFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0.sp)),
          ],
        ),
        SizedBox(height: 2),
        Row(
          children: [
            Text(
              Langue.deplac[
                  Provider.of<VoiceData>(context, listen: false).langue],
              style: TextStyle(
                  color: violetFont,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0.sp),
            ),
            Spacer(),
            Text("-2000" + " FCFA",
                style: TextStyle(
                    color: redFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0.sp)),
          ],
        ),
      ],
    );
  }
}
