import 'package:progress_state_button/progress_button.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/userAuth.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/services/auth.dart';
import 'package:ucolis/src/views/components/simpleButtonLoading.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class _SignUpState extends State<SignUp> {
  TextEditingController email = new TextEditingController();

  TextEditingController password = new TextEditingController();

  String phone;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService _auth = new AuthService();
    ButtonState stateOnlyText = ButtonState.idle;

    final _size = MediaQuery.of(context).size;
    final _orientation = MediaQuery.of(context).orientation;

    final TextEditingController controller = TextEditingController();

    PhoneNumber number = PhoneNumber(isoCode: 'CI');

    return ScaffoldPlatform(
      activeBackButton: true,
      appBarIconColor: Colors.black,
      backgroundColor: Colors.white,
      drawer: Container(),
      leading: Container(),
      scaffoldState: _drawerKey,
      titleColor: Colors.black,
      appBarTitle:
          Langue.ins1[Provider.of<VoiceData>(context, listen: false).langue],
      child: ListView(
        children: [
          Text(
            Langue.etape[
                    Provider.of<VoiceData>(context, listen: false).langue] +
                " 1/4",
            textAlign: TextAlign.center,
            style: headerStyle,
          ),
          SizedBox(
            height: _orientation == Orientation.portrait
                ? _size.height * .275
                : _size.width * .375,
            child: Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      Provider.of<UserAuth>(context, listen: false)
                          .updatePhone(number.toString());
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: number,
                    textFieldController: controller,
                    formatInput: false,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    onSaved: (PhoneNumber number) {
                      setState(() {
                        number = number;
                      });
                    },
                  ),
                ),
              ],
            )),
          ),
          SizedBox(
            height: _orientation == Orientation.portrait
                ? _size.height * .275
                : _size.width * .375,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                    Langue.ins2[
                        Provider.of<VoiceData>(context, listen: false).langue],
                    textAlign: TextAlign.center,
                    style: messagestyle),
                SizedBox(height: 12),
                SimpleButtonLoading(
                    title: Langue.ins[
                        Provider.of<VoiceData>(context, listen: false).langue],
                    onTap: () => {
                          _auth.phoneauth(context),
                        },
                    state: stateOnlyText)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
