import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/loadingData.dart';
import 'dart:async';
import 'package:ucolis/src/DataHandler/userAuth.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/views/screens/dashboard/dashboard.dart';
import 'package:ucolis/src/views/screens/login/login.dart';
import 'package:ucolis/src/views/screens/mapFromDeliver/mapFromDeliver.dart';

import 'db.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final DbService _internaldb = new DbService();

  // Firebase user one-time fetch
  User get getUser => _auth.currentUser;

  // Firebase user a realtime stream
  Stream<User> get user => _auth.authStateChanges();

  // Determine if Apple Signin is available on device
  Future<bool> get appleSignInAvailable => AppleSignIn.isAvailable();

  /// Sign in with Apple
  Future<User> appleSignIn() async {
    try {
      final AuthorizationResult appleResult =
          await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      if (appleResult.error != null) {
        // handle errors from Apple
      }

      final AuthCredential credential = OAuthProvider('apple.com').credential(
        accessToken:
            String.fromCharCodes(appleResult.credential.authorizationCode),
        idToken: String.fromCharCodes(appleResult.credential.identityToken),
      );

      UserCredential firebaseResult =
          await _auth.signInWithCredential(credential);
      User user = firebaseResult.user;

      // Update user data
      updateUserData(user);

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

//Email auth lOGIN
  Future<User> emailAuthLogin(context, String email, password) async {
    Provider.of<LoadingData>(context, listen: false)
        .updateloadingState(ButtonState.loading);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Provider.of<LoadingData>(context, listen: false)
          .updateloadingState(ButtonState.success);

      FirebaseFirestore.instance
          .collection('users_data')
          .doc(userCredential.user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if (documentSnapshot.get("active") == false) {
            final snackBar = SnackBar(
                content: Text(Langue.auth1[
                    Provider.of<VoiceData>(context, listen: false).langue]));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            if (documentSnapshot.get("AccountType") == "Coursier") {
              final snackBar = SnackBar(
                  content: Text(Langue.auth2[
                      Provider.of<VoiceData>(context, listen: false).langue]));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Get.offAll(MapFromDeliver());
            } else {
              final snackBar = SnackBar(
                  content: Text(Langue.auth3[
                      Provider.of<VoiceData>(context, listen: false).langue]));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Get.offAll(Dashboard());
            }
          }
        } else {
          final snackBar = SnackBar(
              content: Text(Langue.con1[
                  Provider.of<VoiceData>(context, listen: false).langue]));
        }
      });
    } on FirebaseAuthException catch (e) {
      Provider.of<LoadingData>(context, listen: false)
          .updateloadingState(ButtonState.fail);
      if (e.code == 'user-not-found') {
        final snackBar = SnackBar(
            content: Text(Langue
                .auth4[Provider.of<VoiceData>(context, listen: false).langue]));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        final snackBar = SnackBar(
            content: Text(Langue
                .auth5[Provider.of<VoiceData>(context, listen: false).langue]));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
  //  _auth.phoneauth(context),
  //  Get.offAll(MapFromDeliver());

  //Get.toNamed('/dashboard');
  //Reset Email auth
  Future<User> resetPassword(context, email) async {
    Provider.of<LoadingData>(context, listen: false)
        .updateloadingState(ButtonState.loading);

    try {
      await _auth.sendPasswordResetEmail(email: email);
      final snackBar = SnackBar(
          content: Text(Langue.auth6[
                  Provider.of<VoiceData>(context, listen: false).langue] +
              " $email"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Provider.of<LoadingData>(context, listen: false)
          .updateloadingState(ButtonState.idle);
      ;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        final snackBar = SnackBar(
            content: Text(Langue
                .auth7[Provider.of<VoiceData>(context, listen: false).langue]));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Provider.of<LoadingData>(context, listen: false)
            .updateloadingState(ButtonState.fail);
      }
    }
  }

  ////Email auth
  Future<User> emailAuth(context) async {
    Provider.of<LoadingData>(context, listen: false)
        .updateloadingState(ButtonState.loading);
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: Provider.of<UserAuth>(context, listen: false).email,
              password: Provider.of<UserAuth>(context, listen: false).password);

      User user = result.user;

      // Update user data
      Provider.of<LoadingData>(context, listen: false)
          .updateloadingState(ButtonState.idle);
      Provider.of<UserAuth>(context, listen: false).updateUserUudi(user.uid);
      _internaldb.updateUserEmailData(context);

      updateUserData(user);
      Get.toNamed('/Information');

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        final snackBar = SnackBar(
            content: Text(Langue
                .auth8[Provider.of<VoiceData>(context, listen: false).langue]));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Provider.of<LoadingData>(context, listen: false)
            .updateloadingState(ButtonState.fail);
      } else if (e.code == 'email-already-in-use') {
        final snackBar = SnackBar(
            content: Text(Langue
                .auth9[Provider.of<VoiceData>(context, listen: false).langue]));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Provider.of<LoadingData>(context, listen: false)
            .updateloadingState(ButtonState.fail);
      }
    } catch (e) {
      print(e);
    }
  }

  //auth with phone

  Future<User> phoneauth(context) async {
    Provider.of<LoadingData>(context, listen: false)
        .updateloadingState(ButtonState.loading);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: Provider.of<UserAuth>(context, listen: false).phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) async {
        print(e);
        Provider.of<LoadingData>(context, listen: false)
            .updateloadingState(ButtonState.fail);
        final snackBar = SnackBar(
            content: Text(Langue.auth10[
                Provider.of<VoiceData>(context, listen: false).langue]));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      codeSent: (String verificationId, int resendToken) async {
        Provider.of<LoadingData>(context, listen: false)
            .updateloadingState(ButtonState.idle);
        Provider.of<UserAuth>(context, listen: false)
            .updateCodeVerificationId(verificationId);
        Get.toNamed('/VerificationCode');
      },
      codeAutoRetrievalTimeout: (String verificationId) async {},
    );
  }

  Future<User> verifyPhoneAuthCode(context, String code) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId:
            Provider.of<UserAuth>(context, listen: false).verificationId,
        smsCode: code);

    // Sign the user in (or link) with the credential
    try {
      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;

      // Update user data
      //updateUserData(user);
      final snackBar = SnackBar(
          content: Text(Langue
              .auth11[Provider.of<VoiceData>(context, listen: false).langue]));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (Provider.of<UserAuth>(context, listen: false).authsocial == true) {
        Get.toNamed("/Information");
      } else {
        Get.toNamed("/AccountAccess");
      }

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  /// Sign in with Google
  Future<User> googleSignIn(context) async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;

      // Update user data
      updateUserDataSocailAuth(user, context);

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

//Siginn with facebook
  Future<User> facebookSignIn() async {
    final AccessToken result =
        (await FacebookAuth.instance.login()) as AccessToken;

    // Create a credential from the access token
    final facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(facebookAuthCredential);
  }

  /// Anonymous Firebase login
  Future<User> anonLogin() async {
    final User user = (await _auth.signInAnonymously()).user;
    updateUserData(user);
    return user;
  }

  /// Updates the User's data in Firestore on each new login
  Future<void> updateUserData(User user) {
    DocumentReference reportRef = _db.collection('users_data').doc(user.uid);

    return reportRef.set({'uid': user.uid, 'lastActivity': DateTime.now()},
        SetOptions(merge: true));
  }

  Future<void> updateUserDataSocailAuth(User user, context) {
    Provider.of<UserAuth>(context, listen: false).updateUserUudi(user.uid);
    DocumentReference reportRef = _db.collection('users_data').doc(user.uid);

    FirebaseFirestore.instance
        .collection('users_data')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        FirebaseFirestore.instance
            .collection('users_data')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            if (documentSnapshot.get("active") == false) {
              final snackBar = SnackBar(
                  content: Text(Langue.auth1[
                      Provider.of<VoiceData>(context, listen: false).langue]));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              if (documentSnapshot.get("accountType") == "Coursier") {
                final snackBar = SnackBar(
                    content: Text(Langue.auth2[
                        Provider.of<VoiceData>(context, listen: false)
                            .langue]));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Get.offAll(MapFromDeliver());
              } else {
                final snackBar = SnackBar(
                    content: Text(Langue.auth3[
                        Provider.of<VoiceData>(context, listen: false)
                            .langue]));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Get.offAll(Dashboard());
              }
            }
          } else {
            final snackBar = SnackBar(
                content: Text(Langue.con1[
                    Provider.of<VoiceData>(context, listen: false).langue]));
          }
        });
      } else {
        reportRef.set({
          'profile': user.photoURL,
          'firstname': user.displayName,
          'lastname': user.displayName,
          'email': user.email,
          'uid': user.uid,
          'lastActivity': DateTime.now()
        }, SetOptions(merge: true)).onError((error, stackTrace) {
          final snackBar = SnackBar(
              content: Text(Langue.con1[
                  Provider.of<VoiceData>(context, listen: false).langue]));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }).whenComplete(() {
          Provider.of<UserAuth>(context, listen: false)
              .updateUsername(user.displayName, user.displayName, "");
          Provider.of<UserAuth>(context, listen: false).updateAuthSocial(true);
          Get.toNamed("/SignUp");
        });
      }
    });
  }

  // Sign out
  Future<void> signOut() {
    _auth.signOut();
    Get.offAll(Login());
  }

  Future<void> uploadProfile(context) async {}

  Future<User> authPersistchecker(String uid, context) async {
    try {
      FirebaseFirestore.instance
          .collection('users_data')
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print(documentSnapshot);
          if (documentSnapshot.get("active") == false) {
          } else {
            if (documentSnapshot.get("AccountType") == "Coursier") {
              Provider.of<UserAuth>(context, listen: false).updateUsername(
                  documentSnapshot.get("firstname"),
                  documentSnapshot.get("lastname"),
                  documentSnapshot.get("bithday"));
              Provider.of<UserAuth>(context, listen: false)
                  .updatePhone(documentSnapshot.get("phone"));

              Provider.of<UserAuth>(context, listen: false)
                  .updateRole(documentSnapshot.get("AccountType"));

              Provider.of<UserAuth>(context, listen: false)
                  .updateProfileImage(documentSnapshot.get("profile"));

              Provider.of<UserAuth>(context, listen: false)
                  .updateUserUudi(documentSnapshot.get("uid"));

              Get.offAll(MapFromDeliver());
            } else {
              Get.offAll(Dashboard());
            }
          }
        } else {
          Get.offAll(OnboardingScreen());
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
    }
  }
}
