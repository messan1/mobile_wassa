import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/views/screens/Auth/components/imageLoader.dart';
import 'package:ucolis/src/views/screens/Auth/components/linkButton.dart';
import 'package:ucolis/src/views/screens/Auth/components/platformTextFieldForm.dart';
import 'package:ucolis/src/views/screens/Auth/components/simpleButton.dart';
import 'package:ucolis/src/views/screens/Auth/components/verticalSeparator.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';

class ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientation = MediaQuery.of(context).orientation;
    return ScaffoldPlatform(
      appBarTitle: Langue
          .verif3[Provider.of<VoiceData>(context, listen: false).langue]
          .toUpperCase(),
      child: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: SizeCalculator.width(context, width: .085)),
        children: [
          SizedBox(
            height: _orientation == Orientation.portrait
                ? _size.height * .57
                : _size.width * .25,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                  child: ImageLoader(image: "assets/images/limage2.png")),
            ),
          ),
          PlatformTextFieldForm.textFieldPlatform(
              title: Langue.verif4[
                  Provider.of<VoiceData>(context, listen: false).langue],
              verticalContentPadding:
                  SizeCalculator.height(context, height: .0175)),
          SizedBox(height: SizeCalculator.height(context, height: .045)),
          SimpleButton(
            title: Langue
                .verif5[Provider.of<VoiceData>(context, listen: false).langue],
            onTap: () {},
          ),
          VerticalSeparator(height: .075),
          LinkButton(
            title: Langue
                .res1[Provider.of<VoiceData>(context, listen: false).langue],
            onTap: () {
              Navigator.pop(context);
            },
          ),
          VerticalSeparator(),
        ],
      ),
    );
  }
}
