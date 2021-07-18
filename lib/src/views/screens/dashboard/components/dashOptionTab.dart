import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/dashboard/components/serviceButton.dart';
import 'package:ucolis/src/views/screens/dashboard/components/talkButton.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class DashOptionTab extends StatelessWidget {
  const DashOptionTab({
    Key key,
  }) : super(key: key);
  static get _motor => "motor";
  static get _cars => "cars";
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      color: whiteFont,
      height: 36.0.h,
      personalizeBorderRadius:
          BorderRadius.vertical(top: Radius.circular(30..h)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ExtendedContainer(
            height: 5..h,
            width: 30..w,
            useBorderRadius: true,
            color: Colors.blueGrey.withOpacity(.35),
          ),
          Row(
            children: [
              ServiceButton(
                  title: Langue.colis[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  image: "assets/icon/motor.svg",
                  onPressed: () =>
                      Get.toNamed("/destination", arguments: _motor)),
              ServiceButton(
                  title: Langue.transport[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  image: "assets/icon/cars.svg",
                  onPressed: () =>
                      Get.toNamed("/choixAdress", arguments: _cars)),
            ],
          ),
          TalkButton(),
        ],
      ),
    );
  }
}
