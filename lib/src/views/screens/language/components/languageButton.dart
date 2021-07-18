import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/views/screens/Auth/components/extendedContainer.dart';

import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    Key key,
    @required this.language,
    @required this.countryCode,
  }) : super(key: key);
  final String language;
  final String countryCode;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      height: .087,
      useBorderRadius: true,
      color: blackFont,
      margin: EdgeInsets.symmetric(
          horizontal: SizeCalculator.width(context, width: .1),
          vertical: SizeCalculator.height(context, height: .0095)),
      child: Material(
        borderRadius: BorderRadius.circular(SizeCalculator.radiusCalculate(
            SizeCalculator.height(context, height: .095))),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SizeCalculator.radiusCalculate(
              SizeCalculator.height(context, height: .095))),
          onTap: () {
            switch (countryCode) {
              case "FR":
                Provider.of<VoiceData>(context, listen: false)
                    .updateLangue('fr');
                break;
              case "BF":
                Provider.of<VoiceData>(context, listen: false)
                    .updateLangue('more');
                break;
              case "ML":
                Provider.of<VoiceData>(context, listen: false)
                    .updateLangue('dioula');
                break;
              case "US":
                Provider.of<VoiceData>(context, listen: false)
                    .updateLangue('en');
                break;
              default:
                Provider.of<VoiceData>(context, listen: false)
                    .updateLangue('fr');
            }
            Get.toNamed('/Login');
          },
          child: Padding(
            padding: EdgeInsets.only(
                left: SizeCalculator.width(context, width: .13)),
            child: Row(
              children: [
                Flag(
                  countryCode.toUpperCase(),
                  height: SizeCalculator.height(context, height: .095),
                  width: SizeCalculator.width(context, width: .085),
                ),
                SizedBox(width: SizeCalculator.width(context, width: .065)),
                Text(
                  language.toUpperCase(),
                  style: buttonStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
