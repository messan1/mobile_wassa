import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ucolis/src/views/components/simpleButtonLoading.dart';
import 'package:smart_select/smart_select.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'components/choices.dart' as choices;
import 'package:sizer/sizer.dart';

import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/userAuth.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/services/db.dart';
import 'package:ucolis/src/views/screens/Auth/components/platformTextFieldForm.dart';
import 'package:ucolis/src/views/screens/Auth/components/verticalSeparator.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class InfoVehicule extends StatefulWidget {
  @override
  _InfoVehiculeState createState() => _InfoVehiculeState();
}

class _InfoVehiculeState extends State<InfoVehicule> {
  TextEditingController _dateController = TextEditingController();
  DateTime bithdate = null;
  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();
  File image;
  DbService _db = new DbService();

  Future _selectDate(BuildContext context) async {
    DatePicker.showDatePicker(context, showTitleActions: true,
        onConfirm: (date) {
      _dateController.text = date.toString().substring(0, 11);
    }, currentTime: DateTime.now(), locale: LocaleType.fr);
    print(bithdate.toString());
  }

  @override
  void dispose() {
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

      super.initState();
    }

    _Save() async {
      if (_firstnameController.text.isNotEmpty &&
          _lastnameController.text.isNotEmpty &&
          _dateController.text.isNotEmpty &&
          image != null) {
        Provider.of<UserAuth>(context, listen: false).updateUsername(
            _lastnameController.text,
            _firstnameController.text,
            _dateController.text);
        _db.uploadFile(context, image);

        //var response = await AuthAssistanceMethods.signupUser(context);

      } else {
        _disableLoading();

        _showError(Langue
            .verif6[Provider.of<VoiceData>(context, listen: false).langue]);
      }
    }

    int _car = 1;
    return ScaffoldPlatform(
      appBarTitle: "Informations sur votre véhicule",
      activeBackButton: false,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: SizeCalculator.width(context, width: .085)),
          children: [
            Column(
              children: [
                SmartSelect<int>.single(
                  onChange: (selected) => setState(() => _car = selected.value),
                  modalConfirm: true,
                  title: 'Type de Véhicule',
                  placeholder:
                      Provider.of<UserAuth>(context, listen: true).typeVehicule,
                  modalType: S2ModalType.bottomSheet,
                  modalHeader: false,
                  choiceItems: S2Choice.listFrom<int, Map<String, dynamic>>(
                    source: choices.transports,
                    value: (index, item) => index,
                    title: (index, item) => item['title'],
                    subtitle: (index, item) => item['subtitle'],
                    meta: (index, item) => item,
                  ),
                  choiceLayout: S2ChoiceLayout.wrap,
                  choiceDirection: Axis.horizontal,
                  choiceBuilder: (context, state, choice) {
                    return Card(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: InkWell(
                        onTap: () => {
                          Provider.of<UserAuth>(context, listen: false)
                              .updateVehicule(choices
                                  .transports[state.value].entries.first.value),
                          Navigator.pop(context)
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(height: 5),
                                WebsafeSvg.asset(
                                    "assets/icon/${choices.transports[state.value].entries.last.value}",
                                    height: 5.5.h),
                                Text(
                                  choices.transports[state.value].entries.first
                                      .value,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  tileBuilder: (context, state) {
                    return S2Tile.fromState(
                      state,
                      isTwoLine: true,
                      leading: WebsafeSvg.asset("assets/icon/cars.svg",
                          height: 5.5.h),
                    );
                  },
                  value: null,
                ),
                VerticalSeparator(),
                SmartSelect<int>.single(
                  onChange: (selected) => setState(() => _car = selected.value),
                  modalConfirm: true,
                  title: 'Disposez-vous de la climatisation',
                  placeholder:
                      Provider.of<UserAuth>(context, listen: true).typeVehicule,
                  modalType: S2ModalType.bottomSheet,
                  modalHeader: false,
                  choiceItems: S2Choice.listFrom<int, Map<String, dynamic>>(
                    source: choices.transports,
                    value: (index, item) => index,
                    title: (index, item) => item['title'],
                    subtitle: (index, item) => item['subtitle'],
                    meta: (index, item) => item,
                  ),
                  choiceLayout: S2ChoiceLayout.wrap,
                  choiceDirection: Axis.horizontal,
                  choiceBuilder: (context, state, choice) {
                    return Card(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: InkWell(
                        onTap: () => {
                          Provider.of<UserAuth>(context, listen: false)
                              .updateVehicule(choices
                                  .transports[state.value].entries.first.value),
                          Navigator.pop(context)
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(height: 5),
                                WebsafeSvg.asset(
                                    "assets/icon/${choices.transports[state.value].entries.last.value}",
                                    height: 5.5.h),
                                Text(
                                  choices.transports[state.value].entries.first
                                      .value,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  tileBuilder: (context, state) {
                    return S2Tile.fromState(
                      state,
                      isTwoLine: true,
                      leading: WebsafeSvg.asset(
                          "assets/icon/air-conditioner.svg",
                          width: 9.5.h,
                          height: 5.5.h),
                    );
                  },
                  value: null,
                ),
                VerticalSeparator(),
                SmartSelect<int>.single(
                  onChange: (selected) => setState(() => _car = selected.value),
                  modalConfirm: true,
                  title: 'Type de Véhicule',
                  placeholder:
                      Provider.of<UserAuth>(context, listen: true).typeVehicule,
                  modalType: S2ModalType.bottomSheet,
                  modalHeader: false,
                  choiceItems: S2Choice.listFrom<int, Map<String, dynamic>>(
                    source: choices.transports,
                    value: (index, item) => index,
                    title: (index, item) => item['title'],
                    subtitle: (index, item) => item['subtitle'],
                    meta: (index, item) => item,
                  ),
                  choiceLayout: S2ChoiceLayout.wrap,
                  choiceDirection: Axis.horizontal,
                  choiceBuilder: (context, state, choice) {
                    return Card(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: InkWell(
                        onTap: () => {
                          Provider.of<UserAuth>(context, listen: false)
                              .updateVehicule(choices
                                  .transports[state.value].entries.first.value),
                          Navigator.pop(context)
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(height: 5),
                                WebsafeSvg.asset(
                                    "assets/icon/${choices.transports[state.value].entries.last.value}",
                                    height: 5.5.h),
                                Text(
                                  choices.transports[state.value].entries.first
                                      .value,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  tileBuilder: (context, state) {
                    return S2Tile.fromState(
                      state,
                      isTwoLine: true,
                      leading: WebsafeSvg.asset("assets/icon/cars.svg",
                          height: 5.5.h),
                    );
                  },
                  value: null,
                ),
                VerticalSeparator(),
                SmartSelect<int>.single(
                  onChange: (selected) => setState(() => _car = selected.value),
                  modalConfirm: true,
                  title: 'Type de Véhicule',
                  placeholder:
                      Provider.of<UserAuth>(context, listen: true).typeVehicule,
                  modalType: S2ModalType.bottomSheet,
                  modalHeader: false,
                  choiceItems: S2Choice.listFrom<int, Map<String, dynamic>>(
                    source: choices.transports,
                    value: (index, item) => index,
                    title: (index, item) => item['title'],
                    subtitle: (index, item) => item['subtitle'],
                    meta: (index, item) => item,
                  ),
                  choiceLayout: S2ChoiceLayout.wrap,
                  choiceDirection: Axis.horizontal,
                  choiceBuilder: (context, state, choice) {
                    return Card(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: InkWell(
                        onTap: () => {
                          Provider.of<UserAuth>(context, listen: false)
                              .updateVehicule(choices
                                  .transports[state.value].entries.first.value),
                          Navigator.pop(context)
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(height: 5),
                                WebsafeSvg.asset(
                                    "assets/icon/${choices.transports[state.value].entries.last.value}",
                                    height: 5.5.h),
                                Text(
                                  choices.transports[state.value].entries.first
                                      .value,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  tileBuilder: (context, state) {
                    return S2Tile.fromState(
                      state,
                      isTwoLine: true,
                      leading: WebsafeSvg.asset("assets/icon/cars.svg",
                          height: 5.5.h),
                    );
                  },
                  value: null,
                ),
                VerticalSeparator(),
                SmartSelect<int>.single(
                  onChange: (selected) => setState(() => _car = selected.value),
                  modalConfirm: true,
                  title: 'Type de Véhicule',
                  placeholder:
                      Provider.of<UserAuth>(context, listen: true).typeVehicule,
                  modalType: S2ModalType.bottomSheet,
                  modalHeader: false,
                  choiceItems: S2Choice.listFrom<int, Map<String, dynamic>>(
                    source: choices.transports,
                    value: (index, item) => index,
                    title: (index, item) => item['title'],
                    subtitle: (index, item) => item['subtitle'],
                    meta: (index, item) => item,
                  ),
                  choiceLayout: S2ChoiceLayout.wrap,
                  choiceDirection: Axis.horizontal,
                  choiceBuilder: (context, state, choice) {
                    return Card(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: InkWell(
                        onTap: () => {
                          Provider.of<UserAuth>(context, listen: false)
                              .updateVehicule(choices
                                  .transports[state.value].entries.first.value),
                          Navigator.pop(context)
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(height: 5),
                                WebsafeSvg.asset(
                                    "assets/icon/${choices.transports[state.value].entries.last.value}",
                                    height: 5.5.h),
                                Text(
                                  choices.transports[state.value].entries.first
                                      .value,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  tileBuilder: (context, state) {
                    return S2Tile.fromState(
                      state,
                      isTwoLine: true,
                      leading: WebsafeSvg.asset("assets/icon/cars.svg",
                          height: 5.5.h),
                    );
                  },
                  value: null,
                ),
                VerticalSeparator(),
                SmartSelect<int>.single(
                  onChange: (selected) => setState(() => _car = selected.value),
                  modalConfirm: true,
                  title: 'Type de Véhicule',
                  placeholder:
                      Provider.of<UserAuth>(context, listen: true).typeVehicule,
                  modalType: S2ModalType.bottomSheet,
                  modalHeader: false,
                  choiceItems: S2Choice.listFrom<int, Map<String, dynamic>>(
                    source: choices.transports,
                    value: (index, item) => index,
                    title: (index, item) => item['title'],
                    subtitle: (index, item) => item['subtitle'],
                    meta: (index, item) => item,
                  ),
                  choiceLayout: S2ChoiceLayout.wrap,
                  choiceDirection: Axis.horizontal,
                  choiceBuilder: (context, state, choice) {
                    return Card(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: InkWell(
                        onTap: () => {
                          Provider.of<UserAuth>(context, listen: false)
                              .updateVehicule(choices
                                  .transports[state.value].entries.first.value),
                          Navigator.pop(context)
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(height: 5),
                                WebsafeSvg.asset(
                                    "assets/icon/${choices.transports[state.value].entries.last.value}",
                                    height: 5.5.h),
                                Text(
                                  choices.transports[state.value].entries.first
                                      .value,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  tileBuilder: (context, state) {
                    return S2Tile.fromState(
                      state,
                      isTwoLine: true,
                      leading: WebsafeSvg.asset("assets/icon/cars.svg",
                          height: 5.5.h),
                    );
                  },
                  value: null,
                ),
                VerticalSeparator(),
                VerticalSeparator(),
              ],
            ),
            VerticalSeparator(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleButtonLoading(
                  title: Langue.save[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  onTap: () {
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
