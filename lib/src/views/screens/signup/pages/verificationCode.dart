import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/userAuth.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';

import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/screens/signup/components/inputForPhoneNumber.dart';
import 'package:ucolis/src/views/screens/signup/components/numericPad.dart';
import 'package:ucolis/src/views/screens/styles/styles.dart';

class VerificationCode extends StatefulWidget {


  const VerificationCode({Key key}) : super(key: key);

  @override
  _VerificationCodeState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  String phone;
  String code;
  bool _timerIsEnd;
  int _initTime = 30;
  int _begin = 30;
  Timer _timer;

  String _verificationCode;

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_begin == 0) {
          setState(() {
            _timerIsEnd = true;
            _initTime = _initTime + 30;
            timer.cancel();
          });
        } else {
          setState(() {
            _begin--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    phone = "+225" + Provider.of<UserAuth>(context, listen: false).phoneNumber;

    _startTimer();
    final _userBloc = Provider.of<UserBloc>(context, listen: false);
    _userBloc.smsCode.listen((event) {
      code = event;
    });
    _userBloc.verification.listen((event) {
      _verificationCode = event;
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer != null ? _timer.cancel() : print(_timer);
    final _userBloc = UserBloc();
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _orientation = MediaQuery.of(context).orientation;
    final _userBloc = Provider.of<UserBloc>(context);
    return ScaffoldPlatform(
      appBarTitle:
          Langue.ins5[Provider.of<VoiceData>(context, listen: false).langue],
      child: SafeArea(
        child: ListView(
          children: [
            Text(
              Langue.etape[
                      Provider.of<VoiceData>(context, listen: false).langue] +
                  " 2/4",
              textAlign: TextAlign.center,
              style: headerStyle,
            ),
            SizedBox(
              height: _orientation == Orientation.portrait
                  ? _size.height * .435
                  : _size.height * .285,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeCalculator.width(context, width: .2)),
                      child: Text(
                        Langue.ins6[
                                Provider.of<VoiceData>(context, listen: false)
                                    .langue] +
                            " $phone",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: greyFont, fontWeight: FontWeight.w900),
                      ),
                    ),
                    StreamBuilder<String>(
                        stream: _userBloc.smsCode,
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              InputForPhoneNumber(
                                phone: code,
                                inputLength: 6,
                              ),
                              SizedBox(
                                  height: SizeCalculator.height(context,
                                      height: .025)),
                              GestureDetector(
                                onTap: _begin == 0
                                    ? () {
                                        setState(() {
                                          _begin = _initTime;
                                          _timerIsEnd = false;
                                          _startTimer();
                                        });
                                      }
                                    : null,
                                child: Text(
                                  _timerIsEnd != true
                                      ? Langue.ins7[Provider.of<VoiceData>(
                                                  context,
                                                  listen: false)
                                              .langue] +
                                          ' (0:$_begin)'
                                      : Langue.ins7[Provider.of<VoiceData>(
                                              context,
                                              listen: false)
                                          .langue],
                                  style: _timerIsEnd != true
                                      ? linkStyle.copyWith(
                                          color: greyFont,
                                          decorationColor: greyFont)
                                      : linkStyle,
                                ),
                              ),
                            ],
                          );
                        })
                  ],
                ),
              ),
            ),
            NumericPad(
                orientation: _orientation, userBloc: _userBloc, isCode: true),
          ],
        ),
      ),
    );
  }
}
