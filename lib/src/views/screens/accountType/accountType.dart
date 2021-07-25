import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucolis/src/services/auth.dart';
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

class AccountType extends StatefulWidget {
  @override
  _AccountTypeState createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
  AuthService _db = new AuthService();

  @override
  void dispose() {
    final _userBloc = UserBloc();
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int _car = 1;
    return ScaffoldPlatform(
      appBarTitle: "Changer de type de compte",
      activeBackButton: false,
      child: SafeArea(
        child: Column(
          children: [
            SmartSelect<int>.single(
              onChange: (selected) => setState(() => _car = selected.value),
              modalConfirm: true,
              title: "Choisir le type de compte",
              placeholder: Provider.of<UserAuth>(context, listen: true).role,
              modalType: S2ModalType.bottomSheet,
              modalHeader: false,
              choiceItems: S2Choice.listFrom<int, Map<String, dynamic>>(
                source: choices.roles,
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
                      Provider.of<UserAuth>(context, listen: false).updateRole(
                          choices.roles[state.value].entries.first.value),
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
                                "assets/icon/${choices.roles[state.value].entries.last.value}",
                                height: 5.5.h),
                            Text(
                              choices.roles[state.value].entries.first.value,
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
                  leading:
                      WebsafeSvg.asset("assets/icon/cars.svg", height: 5.5.h),
                );
              },
              value: null,
            ),
            Spacer(),
            SimpleButtonLoading(
              title: Langue
                  .save[Provider.of<VoiceData>(context, listen: false).langue],
              onTap: () async {
                if (Provider.of<UserAuth>(context, listen: false).role.isEmpty) {
                  Get.back();
                } else {
                   _db.requestRoleChange(context);
                }
              },
              state: null,
            ),
          ],
        ),
      ),
    );
  }
}
