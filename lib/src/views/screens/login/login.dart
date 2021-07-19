import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/loadingData.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';

import 'package:ucolis/src/Model/AuthState.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/constants/constAudio.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/services/auth.dart';
import 'package:ucolis/src/utils/Assistance/AuthAssistanceMethods.dart';
import 'package:ucolis/src/views/components/simpleButtonLoading.dart';
import 'package:ucolis/src/views/components/voiceCommand.dart';
import 'package:ucolis/src/views/screens/Auth/components/linkButton.dart';
import 'package:ucolis/src/views/screens/Auth/components/platformTextFieldForm.dart';
import 'package:ucolis/src/views/screens/Auth/components/simpleButton.dart';
import 'package:ucolis/src/views/screens/Auth/components/verticalSeparator.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ucolis/src/views/screens/dashboard/dashboard.dart';
import 'package:ucolis/src/views/screens/mapFromDeliver/mapFromDeliver.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'components/networkGroup.dart';
import 'components/separator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    Provider.of<LoadingData>(context, listen: false)
        .updateloadingState(ButtonState.idle);
    setupPlaylist();
    if (Provider.of<VoiceData>(context, listen: false).activercommandeVocal)
      playAudio();
    super.initState();
  }

  void setupPlaylist() async {
    List<Audio> arr = [];
    for (String i in data[2]
        [Provider.of<VoiceData>(context, listen: false).langue]) {
      arr.add(Audio('assets/' + i));
    }
    audioPlayer.open(Playlist(audios: arr),
        showNotification: false, autoStart: true);
  }

  playAudio() async {
    await audioPlayer.play();
    audioPlayer.playlistFinished.listen((finished) {
      if (finished) {
        print("fini");
        //Navigator.of(context).pop();
      }
    });
  }

  var logger = Logger();

  TextEditingController email = new TextEditingController();

  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientation = MediaQuery.of(context).orientation;

    _showLoading() {
      EasyLoading.show(
        status: Langue
            .charg1[Provider.of<VoiceData>(context, listen: false).langue],
        maskType: EasyLoadingMaskType.black,
      );
      EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
      EasyLoading.instance.maskType = EasyLoadingMaskType.black;
      EasyLoading.instance.animationStyle = EasyLoadingAnimationStyle.opacity;
      EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.pulse;
    }

    _showError(msg) {
      EasyLoading.showError(msg);
      EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
      EasyLoading.instance.maskType = EasyLoadingMaskType.black;
      EasyLoading.instance.animationStyle = EasyLoadingAnimationStyle.opacity;
      EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.pulse;
    }

    _disableLoading() {
      EasyLoading.dismiss();
    }

    AuthService _auth = new AuthService();
    return ScaffoldPlatform(
        appBarTitle: Langue
            .appName[Provider.of<VoiceData>(context, listen: false).langue],
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeCalculator.width(context, width: .085)),
              children: [
                SizedBox(
                  height: _orientation == Orientation.portrait
                      ? _size.height * .375
                      : _size.width * .375,
                  child: Form(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PlatformTextFieldForm.textFieldPlatform(
                          title: Langue.mail[
                              Provider.of<VoiceData>(context, listen: false)
                                  .langue],
                          verticalContentPadding:
                              SizeCalculator.height(context, height: .0175),
                          controller: email),
                      VerticalSeparator(),
                      PlatformTextFieldForm.textFieldPlatform(
                          title: Langue.pass[
                              Provider.of<VoiceData>(context, listen: false)
                                  .langue],
                          isPassword: true,
                          verticalContentPadding:
                              SizeCalculator.height(context, height: .0175),
                          controller: password),
                    ],
                  )),
                ),
                VerticalSeparator(height: .065),
                SimpleButtonLoading(
                    color: blueFont,
                    title: Langue.con[
                        Provider.of<VoiceData>(context, listen: false).langue],
                    onTap: () => {
                          _auth.emailAuthLogin(
                              context, email.text, password.text)
                        },
                    state: null),
                //Connexion
                VerticalSeparator(height: .0175),

                SimpleButton(
                  title: Langue.ins[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  onTap: () {
                    Get.toNamed("/SignUp");
                  },
                ),
                //Inscription
                Separator(
                  title: 'ou utiliser',
                ),
                NetworkGroup(),
                VerticalSeparator(),
                LinkButton(
                  title: Langue.forget[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  onTap: () async {
                    Get.toNamed('/ResetPassword');
                  },
                ),
                VerticalSeparator(),
              ],
            ),
          ],
        ));
  }

  void onPressedCustomButton() {
    logger.d("Logger is working!");
    Get.toNamed('/Login');
  }
}
