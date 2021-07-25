import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ucolis/src/app/Endpoint.dart';
import 'package:ucolis/src/services/auth.dart';
import 'package:ucolis/src/services/dbservice.dart';
import 'package:ucolis/src/views/components/simpleButtonLoading.dart';

import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/userAuth.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/constants/constLangue.dart';

import 'package:ucolis/src/views/screens/Auth/components/dropDownButton.dart';
import 'package:ucolis/src/views/screens/Auth/components/imageLoader.dart';
import 'package:ucolis/src/views/screens/Auth/components/imageLoaderFromNetwork.dart';
import 'package:ucolis/src/views/screens/Auth/components/platformTextFieldForm.dart';
import 'package:ucolis/src/views/screens/Auth/components/verticalSeparator.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ucolis/src/views/screens/settings/globalFunction.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:logger/logger.dart';

class UpdateUserInfo extends StatefulWidget {
  @override
  _UpdateUserInfoState createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  TextEditingController _dateController = TextEditingController();
  String accountType = "Client";
  AuthService _auth = new AuthService();
  var logger = Logger();

  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();
  File image;
  AuthService _db = new AuthService();
  UserDBservice db = UserDBservice();

  Future _selectDate(BuildContext context) async {
    DatePicker.showDatePicker(context, showTitleActions: true,
        onConfirm: (date) {
      _dateController.text = date.toString().substring(0, 11);
    }, currentTime: DateTime.now(), locale: LocaleType.fr);
  }

  @override
  void dispose() {
    logger.d("Dispose");

    _dateController?.dispose();
    final _userBloc = UserBloc();
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _userBloc = Provider.of<UserBloc>(context);

    String firstname = "";
    String lastname = "";
    String bith = "";
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

    @override
    void initState() {
      logger.d("init", _auth.getUser);

      final _userBloc = Provider.of<UserBloc>(context, listen: false);
      _userBloc.firstName.listen((event) {
        firstname = event;
      });

      _userBloc.lastName.listen((event) {
        lastname = event;
      });

      _userBloc.bithday.listen((event) {
        bith = event;
      });
      if (_auth.getUser != null) {
        var names = _auth.getUser.displayName.split(" ");
        _lastnameController.text = names[0];
        _firstnameController.text = names[1];
      }

      super.initState();
    }

    _Save() async {

       if (_firstnameController.text.isNotEmpty &&
            _lastnameController.text.isNotEmpty) {
          Provider.of<UserAuth>(context, listen: false).updateUsername(
              _lastnameController.text,
              _firstnameController.text,
              _dateController.text);
          _db.updateuserInfo(context, image);

          //var response = await AuthAssistanceMethods.signupUser(context);

        }else {
          _disableLoading();

          _showError(Langue
              .verif6[Provider.of<VoiceData>(context, listen: false).langue]);
        }

    }

    if (_auth.getUser != null) {
      var names = _auth.getUser.displayName.split(" ");
      _lastnameController.text = names[0];
      _firstnameController.text = names[1];
    }
    return ScaffoldPlatform(
      appBarTitle:
          Langue.ins4[Provider.of<VoiceData>(context, listen: false).langue],
      activeBackButton: false,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: SizeCalculator.width(context, width: .085)),
          children: [
            SizedBox(
              height: _size.height * .3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                    child: Stack(
                  children: [
                    image == null
                        ? ImageLoader(image: "assets/photoUser.png")
                        : ExtendedImage.file(image),
                    Positioned(
                      child: Material(
                        shape: StadiumBorder(),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(_size.height),
                          onTap: () async {
                            var imagepicker =
                                await GlobalFunction.imageGetter(context);
                            setState(() {
                              image = imagepicker;
                            });
                          },
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            color: greyFont,
                            size: 30,
                          ),
                        ),
                      ),
                      bottom: 0,
                      top: 0,
                      left: 0,
                      right: 0,
                    ),
                  ],
                )),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PlatformTextFieldForm.textFieldPlatform(
                    title: Langue.nom[
                        Provider.of<VoiceData>(context, listen: false).langue],
                    verticalContentPadding:
                        SizeCalculator.height(context, height: .0175),
                    controller: _firstnameController),
                VerticalSeparator(),
                PlatformTextFieldForm.textFieldPlatform(
                    title: Langue.prenom[
                        Provider.of<VoiceData>(context, listen: false).langue],
                    verticalContentPadding:
                        SizeCalculator.height(context, height: .0175),
                    controller: _lastnameController),
                VerticalSeparator(),
                FutureBuilder(
                    future: db.getUserInformation(),
                    builder: (context, AsyncSnapshot snap) {
                      if (snap.hasData) {
                   
                        _dateController.text = snap.data["birthday"];
                        return GestureDetector(
                          child: PlatformTextFieldForm.textFieldPlatform(
                              controller: _dateController,
                              enabled: false,
                              title: Langue.ddn[
                                  Provider.of<VoiceData>(context, listen: false)
                                      .langue],
                              verticalContentPadding: 20,
                              suffix: IconButton(
                                icon: Icon(
                                  Platform.isIOS
                                      ? CupertinoIcons.calendar
                                      : Icons.calendar_today_rounded,
                                  color: blackFont,
                                ),
                                onPressed: () async {
                                  await _selectDate(context);
                                },
                              )),
                          onTap: () async {
                            await _selectDate(context);
                          },
                        );
                      }
                      return GestureDetector(
                        child: PlatformTextFieldForm.textFieldPlatform(
                            controller: _dateController,
                            enabled: false,
                            title: Langue.ddn[
                                Provider.of<VoiceData>(context, listen: false)
                                    .langue],
                            verticalContentPadding: 20,
                            suffix: IconButton(
                              icon: Icon(
                                Platform.isIOS
                                    ? CupertinoIcons.calendar
                                    : Icons.calendar_today_rounded,
                                color: blackFont,
                              ),
                              onPressed: () async {
                                await _selectDate(context);
                              },
                            )),
                        onTap: () async {
                          await _selectDate(context);
                        },
                      );
                    })
              ],
            ),
            VerticalSeparator(),
            Provider.of<UserAuth>(context, listen: false).authsocial == true
                ? DropButton(
                    items: [
                      Langue.type1[
                          Provider.of<VoiceData>(context, listen: false)
                              .langue],
                      Langue.type2[
                          Provider.of<VoiceData>(context, listen: false)
                              .langue],
                    ],
                    title: Langue.type[
                        Provider.of<VoiceData>(context, listen: false).langue],
                    value: accountType,
                    onChanged: (value) {
                      Provider.of<UserAuth>(context, listen: false)
                          .updateRole(value);

                      setState(() {
                        if (value ==
                            Langue.type2[
                                Provider.of<VoiceData>(context, listen: false)
                                    .langue]) accountType = "Coursier";
                        if (value ==
                            Langue.type1[
                                Provider.of<VoiceData>(context, listen: false)
                                    .langue]) accountType = "Client";
                      });
                    },
                  )
                : Container(),
            VerticalSeparator(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleButtonLoading(
                  title: Langue.save[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  onTap: () {
                    //print(Provider.of<UserAuth>(context, listen: false).role);

                    // _showLoading();
                    _Save();
                  },
                  state: null,
                ),
                VerticalSeparator(height: .014),
              ],
            )
          ],
        ),
      ),
    );
  }
}
