import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';

import 'package:provider/provider.dart';

import 'package:ucolis/src/DataHandler/userAuth.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/services/auth.dart';
import 'package:ucolis/src/utils/Assistance/AuthAssistanceMethods.dart';
import 'package:ucolis/src/views/components/loadingButton.dart';
import 'package:ucolis/src/views/components/simpleButtonLoading.dart';

import 'package:ucolis/src/views/screens/Auth/components/dropDownButton.dart';
import 'package:ucolis/src/views/screens/Auth/components/imageLoader.dart';

import 'package:ucolis/src/views/screens/Auth/components/platformTextFieldForm.dart';
import 'package:ucolis/src/views/screens/Auth/components/simpleButton.dart';
import 'package:ucolis/src/views/screens/Auth/components/verticalSeparator.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/screens/styles/styles.dart';

class AccountAccess extends StatefulWidget {
  @override
  _AccountAccessState createState() => _AccountAccessState();
}

class _AccountAccessState extends State<AccountAccess> {
  AuthService _auth = new AuthService();

  String accountType = "Client";
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();

  String emaildata = "";
  String passwordData = "";

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientation = MediaQuery.of(context).orientation;
    final _userBloc = Provider.of<UserBloc>(context);

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
      _userBloc.email.listen((event) {
        emaildata = event;
      });

      _userBloc.password.listen((event) {
        passwordData = event;
      });

      super.initState();
    }

    _passNextPage() async {
      // ignore: unrelated_type_equality_checks
      if (password.text.isNotEmpty &&
          password.text == confirmpassword.text &&
          email.text.isNotEmpty) {
        Provider.of<UserAuth>(context, listen: false)
            .updateUserAccess(email.text, confirmpassword.text, accountType);
        _auth.emailAuth(context);
      } else {
        _showError(Langue
            .verif2[Provider.of<VoiceData>(context, listen: false).langue]);
      }
    }

    return ScaffoldPlatform(
      appBarTitle:
          Langue.ins3[Provider.of<VoiceData>(context, listen: false).langue],
      activeBackButton: false,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: SizeCalculator.width(context, width: .085)),
          children: [
            Text(
              Langue.etape[
                      Provider.of<VoiceData>(context, listen: false).langue] +
                  " 3/4",
              textAlign: TextAlign.center,
              style: headerStyle,
            ),
            SizedBox(height: SizeCalculator.height(context, height: .03)),
            SizedBox(
              height: _orientation == Orientation.portrait
                  ? _size.height * .2
                  : _size.width * .2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(child: ImageLoader(image: "assets/image2.png")),
              ),
            ),
            PlatformTextFieldForm.textFieldPlatform(
                title: Langue.mail[
                    Provider.of<VoiceData>(context, listen: false).langue],
                controller: email),
            VerticalSeparator(height: .018),
            PlatformTextFieldForm.textFieldPlatform(
                title: Langue.pass[
                    Provider.of<VoiceData>(context, listen: false).langue],
                isPassword: true,
                controller: password),
            VerticalSeparator(height: .018),
            PlatformTextFieldForm.textFieldPlatform(
                title: Langue.passconf[
                    Provider.of<VoiceData>(context, listen: false).langue],
                isPassword: true,
                controller: confirmpassword),
            VerticalSeparator(height: .018),
            DropButton(
              items: [
                Langue.type1[
                    Provider.of<VoiceData>(context, listen: false).langue],
                Langue.type2[
                    Provider.of<VoiceData>(context, listen: false).langue],
                
              ],
              title: Langue
                  .type[Provider.of<VoiceData>(context, listen: false).langue],
              value: accountType,
              onChanged: (value) {
                print(value);
                setState(() {
                  if (value == "Coursier" || value == "Coursier")
                    accountType = "Coursier";
                  if (value == "Client") accountType = "Client";
                  
                });
              },
            ),
            VerticalSeparator(height: .035),
            SimpleButtonLoading(
              title: Langue
                  .sins[Provider.of<VoiceData>(context, listen: false).langue],
              onTap: () {
                // _showLoading();
                _passNextPage();
              },
              state: null,
            )
          ],
        ),
      ),
    );
  }
}
