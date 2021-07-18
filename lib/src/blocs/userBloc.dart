import 'dart:convert';
import 'dart:io';
//import 'package:firebase_core/firebase_core.dart';
import 'package:get/route_manager.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:ucolis/src/services/auth.dart';
import 'package:ucolis/src/views/screens/settings/globalFunction.dart';

class UserBloc {
  AuthService _auth = new AuthService();
  final _picture = BehaviorSubject<File>();
  final _phone = BehaviorSubject<String>();
  final _documents = BehaviorSubject<List<File>>();
  //
  final _smsCode = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _userID = BehaviorSubject<String>();
  final _verificationID = BehaviorSubject<String>();
  //

//Personal Data
  final _firstname = BehaviorSubject<String>();
  final _lastname = BehaviorSubject<String>();
  final _accounttype = BehaviorSubject<String>();
  final _bithday = BehaviorSubject<String>();

  //Setters
  Function(String) get changePhone => _phone.sink.add;
  Function(String) get changeSmsCode => _smsCode.sink.add;
  Function(String) get changeVerification => _verificationID.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changeAccountType => _accounttype.sink.add;
  Function(String) get changeUserID => _userID.sink.add;
  Function(String) get changeFirstName => _firstname.sink.add;
  Function(String) get changeLastName => _lastname.sink.add;
  Function(String) get changeBithDay => _lastname.sink.add;
  Function(String) get changePassword => _password.sink.add;

  //Getters
  Stream<File> get picture => _picture.stream;
  Stream<String> get phone => _phone.stream;
  Stream<String> get smsCode => _smsCode.stream;
  Stream<String> get verification => _verificationID.stream;
  Stream<String> get email => _email.stream;
  Stream<String> get password => _password.stream;
  Stream<String> get userID => _userID.stream;
  Stream<String> get firstName => _password.stream;
  Stream<String> get accounttype => _accounttype.stream;
  Stream<String> get lastName => _password.stream;
  Stream<String> get bithday => _password.stream;
  Stream<List<File>> get documents => _documents.stream;

  //CallBack

  ///If [isCode] is null or false it mean that user is on [SignUp} Screen to enter is phone number
  ///so the [backspace] or [getPhoneOrCode] or [verifyPhoneOrCode] CallBack will be apply according  the value is phone or smsCode.
  ///Important : on [VerificationCode] Screen [isCode] can't be null or false
  void backspace({@required bool isCode}) {
    if (isCode == true) {
      if ((_smsCode.value != null) && (_smsCode.value.length > 0)) {
        changeSmsCode(_smsCode.value.substring(0, _smsCode.value.length - 1));
      }
    } else {
      if ((_phone.value != null) && (_phone.value.length > 0)) {
        changePhone(_phone.value.substring(0, _phone.value.length - 1));
      }
    }
  }

  //
  ///If [isCode] is null or false it mean that user is on [SignUp} Screen to enter is phone number
  ///so the [backspace] or [getPhoneOrCode] or [verifyPhoneOrCode] CallBack will be apply according  the value is phone or smsCode.
  ///Important : on [VerificationCode] Screen [isCode] can't be null or false
  void getPhoneOrCode({@required bool isCode, @required int number}) {
    if (isCode == true) {
      if (_smsCode.value == null) {
        changeSmsCode(_smsCode.value ?? "" + number.toString());
      } else {
        if (!(_smsCode.value.length == 6)) {
          changeSmsCode(_smsCode.value + number.toString());
        }
      }
    } else {
      if (_phone.value == null) {
        changePhone(_phone.value ?? "" + number.toString());
      } else {
        if (!(_phone.value.length == 8)) {
          changePhone(_phone.value + number.toString());
        }
      }
    }
  }

  //
  ///If [isCode] is null or false it mean that user is on [SignUp} Screen to enter is phone number
  ///so the [backspace] or [getPhoneOrCode] or [verifyPhoneOrCode] CallBack will be apply according  the value is phone or smsCode.
  ///Important : on [VerificationCode] Screen [isCode] can't be null or false
  void verifyPhoneOrCode(BuildContext context, {@required bool isCode}) async {
    // 

    _auth.verifyPhoneAuthCode(context, _smsCode.value);
  }

  //External CallBack
  Future<void> imageGetter(BuildContext context) async {
    _picture.sink.add(await GlobalFunction.imageGetter(context));
  }

  List<File> files = [];
  Future<void> documentsGetter(BuildContext context) async {
    File _file = await GlobalFunction.imageGetter(context);
    files.add(_file);
    _documents.sink.add(files);
  }

  Future<void> deleteDoc({@required int index}) async {
    files.removeAt(index);
    _documents.sink.add(files);
  }

  Future<void> addUser(users) {
    return users
        .add({
          // "_id": _userID.value,
          'firstname': _firstname.value,
          'lastname': _lastname.value,
          "email": _email,
          "bithday": _bithday.value,
          "phoneNumber": _phone,
          'accountType': _accounttype.value,
        })
        .then((value) => print("User Added"))
        .catchError((error) => null);
  }

  //Disposer
  dispose() {
    _picture?.close();
    _phone?.close();
    _smsCode?.close();
    _documents?.close();
  }
}
