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


class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Firebase user one-time fetch
  User get getUser => _auth.currentUser;

  // Firebase user a realtime stream
  Stream<User> get user => _auth.authStateChanges();

  //Email auth
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
      updateUserData(user);
      Get.toNamed('/Information');

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        final snackBar =
            SnackBar(content: Text('Le mot de passe fourni est trop faible.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Provider.of<LoadingData>(context, listen: false)
            .updateloadingState(ButtonState.fail);
      } else if (e.code == 'email-already-in-use') {
        final snackBar =
            SnackBar(content: Text('Le compte existe déjà pour cet e-mail.'));
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
        Provider.of<LoadingData>(context, listen: false)
            .updateloadingState(ButtonState.fail);
        final snackBar =
            SnackBar(content: Text('Erreur lors de la verification!'));
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
      final snackBar = SnackBar(content: Text('Votre numero est verifie!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Get.toNamed("/AccountAccess");

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  /// Sign in with Google
  Future<User> googleSignIn() async {
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
      updateUserData(user);

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

//Siginn with facebook
  Future<User> facebookSignIn() async {
    try {
      // Trigger the sign-in flow
      final AccessToken result =
          (await FacebookAuth.instance.login()) as AccessToken;

      // Create a credential from the access token
      final facebookAuthCredential =
          FacebookAuthProvider.credential(result.token);

      //UserCredential result = await FirebaseAuth.instance
      //   .signInWithCredential(facebookAuthCredential);
      // User user = result.user;

      // Update user data
      //updateUserData(user);

      return null;
    } catch (error) {
      print(error);
      return null;
    }
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

  // Sign out
  Future<void> signOut() {
    return _auth.signOut();
  }

  Future<void> uploadProfile() async {

  }
}
