import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';

import 'package:ucolis/src/Model/AuthState.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/constants/constAudio.dart';
import 'package:ucolis/src/constants/constLangue.dart';
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
  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      if (Provider.of<VoiceData>(context, listen: false).activercommandeVocal) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return VoiceDialogBox(
                  audio: data[2]
                      [Provider.of<VoiceData>(context, listen: false).langue],
                  close: false);
            }).then((value) {});
      }
    });
    super.initState();
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
                SimpleButton(
                  title: Langue.con[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  color: blueFont,
                  onTap: () async {
                    _showLoading();

                    Map data = {
                      'username': email.text,
                      'password': password.text
                    };
                    String body = json.encode(data);
                    AuthState authState =
                        await AuthAssistanceMethods.getAuthState(body, context);

                    if (authState == null) {
                      _disableLoading();
                      _showError(Langue.con1[
                          Provider.of<VoiceData>(context, listen: false)
                              .langue]);
                    } else {
                      // Provider.of<AppData>(context, listen: false)
                      //     .updateId(authState.id);
                      if (authState.acsessToken.isNotEmpty &&
                          authState.role == "ROLE_CLIENT") {
                        _disableLoading();

                        Get.offAll(Dashboard());
                      } else if (authState.acsessToken.isNotEmpty &&
                          authState.role == "ROLE_COURSIER") {
                        _disableLoading();

                        Get.offAll(MapFromDeliver());
                      }
                    }

                    //Get.toNamed('/dashboard');
                  },
                ), //Connexion
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
                    Map<Permission, PermissionStatus> statuses =
                        await [Permission.photos].request();
                    print(statuses[Permission.photos]);
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
