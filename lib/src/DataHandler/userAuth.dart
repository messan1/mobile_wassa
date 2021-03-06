import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ucolis/src/Model/AuthState.dart';

class UserAuth extends ChangeNotifier {
  String phoneNumber = "";
  String firstname = "";
  String lastname = "";
  String number = "";
  String verificationcode = "";
  String verificationId = "";
  String bith = "";
  String useruuid = "";
  String email = "";
  String password = "";
  String role = "";
  AuthState authState;
  File profilePicture;

  //authwithSocial
  bool authsocial = false;

  //info véhicule
  String typeVehicule = "Berline";
  String climatisation = "Oui";
  String portiere = "Oui";
  String vitre = "Oui";
  String candy = "Oui";
  String usb = "Oui";
  String space = "Oui";

  void updateVehiculeUsb(String data) {
    usb = data;
    notifyListeners();
  }
    void updateRole(String data) {
    role = data;
    notifyListeners();
  }
    void updateAuthSocial(bool data) {
    authsocial = data;
    notifyListeners();
  }

  void updateVehiculeSpace(String data) {
    space = data;
    notifyListeners();
  }

  void updateVehiculeCandy(String data) {
    candy = data;
    notifyListeners();
  }

  void updateVehiculeClimatisation(String data) {
    climatisation = data;
    notifyListeners();
  }

  void updateVehiculeVitre(String data) {
    vitre = data;
    notifyListeners();
  }

  void updateVehiculePortiere(String data) {
    portiere = data;
    notifyListeners();
  }

  void updateVehicule(String car) {
    typeVehicule = car;
    notifyListeners();
  }

  void updateUserUudi(String date) {
    useruuid = date;
    notifyListeners();
  }

  void updateCodeVerification(String date) {
    verificationcode = date;
    notifyListeners();
  }

  void updateCodeVerificationId(String date) {
    verificationId = date;
    notifyListeners();
  }

  void updatePhone(String phone) {
    phoneNumber = phone;
    notifyListeners();
  }

  void updateUsername(String last, String first, String date) {
    lastname = last;
    firstname = first;
    bith = date;
    notifyListeners();
  }

  void updateUserAccess(
      String dataemail, String datapassword, String datarole) {
    email = dataemail.toLowerCase().trim();
    password = datapassword;
    role = datarole;
    notifyListeners();
  }

  void updateAuthState(AuthState auth) {
    authState = auth;
    notifyListeners();
  }

  void updateProfileImage(File picture) {
    profilePicture = picture;
    notifyListeners();
  }
}
