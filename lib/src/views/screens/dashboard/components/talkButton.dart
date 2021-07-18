import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constAudio.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/components/voiceCommand.dart';
import 'package:ucolis/src/views/screens/dashboard/components/talkDialogBox.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:websafe_svg/websafe_svg.dart';

class TalkButton extends StatefulWidget {
  const TalkButton({
    Key key,
  }) : super(key: key);
  @override
  _TalkButtonState createState() => _TalkButtonState();
}

class _TalkButtonState extends State<TalkButton> {
  static get _motor => "motor";
  static get _cars => "cars";

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      height: 8.5.h,
      width: 8.5.h,
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [Styles.backButtonShadow],
      child: MaterialInkWell(
          customBorder: CircleBorder(),
          child: Center(
            child:
                WebsafeSvg.asset("assets/icon/microphone.svg", height: 25..h),
          ),
          onPressed: () {
            Provider.of<VoiceData>(context, listen: false)
                .updateActiverCommandeVocal(true);
            if (Provider.of<VoiceData>(context, listen: false)
                .activercommandeVocal) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return VoiceDialogBox(
                        audio: data[5][
                            Provider.of<VoiceData>(context, listen: false)
                                .langue],
                        close: false);
                  }).then((value) {
                switch (
                    Provider.of<VoiceData>(context, listen: false).reponse) {
                  case 1:
                    Get.toNamed("/destination", arguments: _motor);
                    break;
                  case 2:
                    Get.toNamed("/choixAdress", arguments: _cars);
                    break;
                  case 3:
                    Get.toNamed("/wallet");
                    break;
                }
              });
            }
          }),
    );
  }
}
