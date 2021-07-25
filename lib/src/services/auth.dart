import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
import 'package:ucolis/src/views/screens/Auth/components/buildShowDialog.dart';
import 'package:ucolis/src/views/screens/OnboardingScreen/OnboardingScreen.dart';
import 'package:ucolis/src/views/screens/dashboard/dashboard.dart';
import 'package:ucolis/src/views/screens/login/login.dart';
import 'package:ucolis/src/views/screens/mapFromDeliver/mapFromDeliver.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

  Future<String> downloadURL(String image) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref('UsersProfiles/$image')
        .getDownloadURL();
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
      updateUserEmailData(context);

      updateUserData(user);

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
      getUser.linkWithPhoneNumber(user.phoneNumber).whenComplete(() {
        if (Provider.of<UserAuth>(context, listen: false).authsocial == true) {
          Get.toNamed("/Information");
        } else {
          Get.toNamed("/AccountAccess");
        }
      });

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
          'isDeleted': false,
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
          if (documentSnapshot.get("active") == false) {
          } else {
            if (documentSnapshot.get("AccountType") == "Coursier") {
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

  /// Updates the User's data in Firestore on each new login
  Future<void> updateUserData(User user) {
    DocumentReference reportRef = _db.collection('users_data').doc(user.uid);

    return reportRef.set({
      'uid': user.uid,
      'lastActivity': DateTime.now(),
      'isDeleted': false,
    }, SetOptions(merge: true));
  }

  Future<void> uploadFile(context, File imageFile) async {
    String name = basename(imageFile.path);
    Provider.of<LoadingData>(context, listen: false)
        .updateloadingState(ButtonState.loading);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('UsersProfiles/$name')
          .putFile(imageFile)
          // ignore: missing_return
          .onError((error, stackTrace) {
        Provider.of<LoadingData>(context, listen: false)
            .updateloadingState(ButtonState.fail);
        final snackBar = SnackBar(content: Text('Vérifiez vos informations'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }).whenComplete(() => {
                updateUserInfoDataInfo(context, name, false),
                Provider.of<LoadingData>(context, listen: false)
                    .updateloadingState(ButtonState.idle)
              });
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> updateuserInfo(context, File imageFile) async {
    Provider.of<LoadingData>(context, listen: false)
        .updateloadingState(ButtonState.loading);

    if (imageFile != null) {
      print(imageFile);
      String name = basename(imageFile.path);
      try {
        await firebase_storage.FirebaseStorage.instance
            .ref('UsersProfiles/$name')
            .putFile(imageFile)
            // ignore: missing_return
            .onError((error, stackTrace) {
          Provider.of<LoadingData>(context, listen: false)
              .updateloadingState(ButtonState.fail);
          final snackBar = SnackBar(content: Text('Vérifiez vos informations'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }).whenComplete(() => {
                  updateUserInfoDataInfo(context, name, true),
                  Provider.of<LoadingData>(context, listen: false)
                      .updateloadingState(ButtonState.idle)
                });
      } catch (e) {
        // e.g, e.code == 'canceled'
      }
    } else {
      Provider.of<LoadingData>(context, listen: false)
          .updateloadingState(ButtonState.idle);
      updateUserInfoDataInfoWithoutImage(context);
    }
  }

  Future<void> updateUserEmailData(context) {
    String userUuuid = Provider.of<UserAuth>(context, listen: false).useruuid;

    DocumentReference reportRef = _db.collection('users_data').doc(userUuuid);
    getUser.updateDisplayName(" ");

    return reportRef.set({
      'uid': userUuuid,
      'lastActivity': DateTime.now(),
      'firstname': '',
      'lastname': '',
      'birthday': '',
      'email': Provider.of<UserAuth>(context, listen: false).email,
      'phone': Provider.of<UserAuth>(context, listen: false).phoneNumber,
      'active': false,
      'AccountType': Provider.of<UserAuth>(context, listen: false).role,
    }, SetOptions(merge: true)).whenComplete(() {
      Get.toNamed('/Information');
    });
  }

  Future<void> updateUserInfoData(context, String profile) {
    String userUuuid = Provider.of<UserAuth>(context, listen: false).useruuid;
    DocumentReference reportRef = _db.collection('users_data').doc(userUuuid);

    reportRef.set({
      'uid': userUuuid,
      'profile': profile,
      'isDeleted': false,
      'firstname': Provider.of<UserAuth>(context, listen: false).firstname,
      'lastname': Provider.of<UserAuth>(context, listen: false).lastname,
      'birthday': Provider.of<UserAuth>(context, listen: false).bith,
      'lastActivity': DateTime.now(),
    }, SetOptions(merge: true));
    if (Provider.of<UserAuth>(context, listen: false).role == "Client") {
      final snackBar = SnackBar(
          content: Text(
              'Félicitation pour votre inscription vous pouvez vous connecter'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Get.toNamed('/Login');
    } else {
      // Get.toNamed('/AddDocument');
    }
  }

  void updateUserInfoDataInfo(context, String profile, bool update) {
    getUser.updateDisplayName(
        Provider.of<UserAuth>(context, listen: false).firstname +
            " " +
            Provider.of<UserAuth>(context, listen: false).lastname);

    getUser.updatePhotoURL(profile);

    DocumentReference reportRef = _db.collection('users_data').doc(getUser.uid);
    if (update == true && profile == null) {
      reportRef.set({
        'uid': getUser.uid,
        'profile': profile,
        'isDeleted': false,
        'firstname': Provider.of<UserAuth>(context, listen: false).firstname,
        'lastname': Provider.of<UserAuth>(context, listen: false).lastname,
        'birthday': Provider.of<UserAuth>(context, listen: false).bith,
        'lastActivity': DateTime.now(),
      }, SetOptions(merge: true)).whenComplete(() {
        Get.back();
      });
    } else {
      reportRef.set({
        'uid': getUser.uid,
        'profile': profile,
        'isDeleted': false,
        'firstname': Provider.of<UserAuth>(context, listen: false).firstname,
        'lastname': Provider.of<UserAuth>(context, listen: false).lastname,
        'birthday': Provider.of<UserAuth>(context, listen: false).bith,
        'AccountType': Provider.of<UserAuth>(context, listen: false).role,
        'lastActivity': DateTime.now(),
      }, SetOptions(merge: true)).whenComplete(() {
        if (Provider.of<UserAuth>(context, listen: false).role == "Client") {
          final snackBar = SnackBar(
              content: Text(
                  'Félicitation pour votre inscription vous pouvez vous connecter'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Get.toNamed('/Login');
        } else if (Provider.of<UserAuth>(context, listen: false).role ==
            "Coursier") {
          Get.toNamed('/InfoVehicule');
        } else {
          if (update) {
            Get.toNamed('/Dashboard');
          } else {
            Get.toNamed('/AddDocument');
          }
        }
      });
    }
  }

  void updateUserInfoDataInfoWithoutImage(context) {
    String uid = getUser.uid;

    DocumentReference reportRef = _db.collection('users_data').doc(uid);
    getUser.updateDisplayName(
        Provider.of<UserAuth>(context, listen: false).firstname +
            " " +
            Provider.of<UserAuth>(context, listen: false).lastname);
    reportRef.set({
      'uid': uid,
      'isDeleted': false,
      'firstname': Provider.of<UserAuth>(context, listen: false).firstname,
      'lastname': Provider.of<UserAuth>(context, listen: false).lastname,
      'birthday': Provider.of<UserAuth>(context, listen: false).bith,
      'lastActivity': DateTime.now(),
    }, SetOptions(merge: true)).whenComplete(() {
      final snackBar =
          SnackBar(content: Text('Vos informations ont été modifié'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Get.toNamed('/Dashboard');
    });
  }

  Future<void> updateUserDocuments(context, List<String> docs) {
    String userUuuid = Provider.of<UserAuth>(context, listen: false).useruuid;
    DocumentReference reportRef = _db.collection('users_data').doc(userUuuid);

    reportRef.set({
      'uid': userUuuid,
      'documents': docs,
    }, SetOptions(merge: true));
  }

  Future<void> uploadFiles(List<File> _images, context) async {
    if (_images.length == 0) {
      final snackBar = SnackBar(content: Text('Chargez des documents'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      List<String> fileData = [];

      await Future.wait(_images.map((_image) async {
        fileData.add(basename(_image.path));
        uploadDoc(_image, context);
      }));
      updateUserDocuments(context, fileData);

      Provider.of<LoadingData>(context, listen: false)
          .updateloadingState(ButtonState.success);

      buildShowDialog(context);
    }
  }

  Future<void> uploadDoc(File imageFile, context) async {
    String name = basename(imageFile.path);
    Provider.of<LoadingData>(context, listen: false)
        .updateloadingState(ButtonState.loading);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('UserDocuments/$name')
          .putFile(imageFile)
          // ignore: missing_return
          .onError((error, stackTrace) {
        Provider.of<LoadingData>(context, listen: false)
            .updateloadingState(ButtonState.fail);
        final snackBar = SnackBar(content: Text('Vérifiez vos informations'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }).whenComplete(() => {
                updateUserInfoData(context, name),
                Provider.of<LoadingData>(context, listen: false)
                    .updateloadingState(ButtonState.idle)
              });
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> updateUserInfoCarData(context) {
    Provider.of<LoadingData>(context, listen: false)
        .updateloadingState(ButtonState.loading);
    String userUuuid = Provider.of<UserAuth>(context, listen: false).useruuid;
    DocumentReference reportRef = _db.collection('users_data').doc(userUuuid);
    reportRef.set({
      'uid': userUuuid,
      'isDeleted': false,
      "carInfo": {
        'typeVehicule':
            Provider.of<UserAuth>(context, listen: false).typeVehicule,
        'climatisation':
            Provider.of<UserAuth>(context, listen: false).climatisation,
        'portiere': Provider.of<UserAuth>(context, listen: false).portiere,
        'vitre': Provider.of<UserAuth>(context, listen: false).vitre,
        'candy': Provider.of<UserAuth>(context, listen: false).candy,
        'usb': Provider.of<UserAuth>(context, listen: false).usb,
        'space': Provider.of<UserAuth>(context, listen: false).space,
      },
      'lastActivity': DateTime.now(),
    }, SetOptions(merge: true)).onError((error, stackTrace) {
      final snackBar = SnackBar(content: Text('Une erreur est survenue'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Provider.of<LoadingData>(context, listen: false)
          .updateloadingState(ButtonState.fail);
    }).whenComplete(() => {
          Provider.of<LoadingData>(context, listen: false)
              .updateloadingState(ButtonState.idle),
          Get.toNamed("/AddDocument")
        });
  }

  void requestRoleChange(context) {
    Provider.of<LoadingData>(context, listen: false)
        .updateloadingState(ButtonState.loading);
    String userUuuid = getUser.uid;
    DocumentReference reportRef = _db.collection('users_data').doc(userUuuid);
    reportRef.set({
      'uid': userUuuid,
      'RequestAccountType': Provider.of<UserAuth>(context, listen: false).role,
      'lastActivity': DateTime.now(),
    }, SetOptions(merge: true)).onError((error, stackTrace) {
      final snackBar = SnackBar(content: Text('Une erreur est survenue'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Provider.of<LoadingData>(context, listen: false)
          .updateloadingState(ButtonState.fail);
    }).whenComplete(() {
      final snackBarsuccess =
          SnackBar(content: Text('Votre demande est en cours de validation'));
      ScaffoldMessenger.of(context).showSnackBar(snackBarsuccess);

      Provider.of<LoadingData>(context, listen: false)
          .updateloadingState(ButtonState.idle);
      Get.back();
    });
  }

  void deleteAccount(context) {
    Provider.of<LoadingData>(context, listen: false)
        .updateloadingState(ButtonState.loading);
    String userUuuid = getUser.uid;
    DocumentReference reportRef = _db.collection('users_data').doc(userUuuid);
    getUser.delete().whenComplete(() {
      reportRef.set({
        'uid': userUuuid,
        'isDeleted': true,
        'lastActivity': DateTime.now(),
      }, SetOptions(merge: true)).onError((error, stackTrace) {
        final snackBar = SnackBar(content: Text('Une erreur est survenue'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Provider.of<LoadingData>(context, listen: false)
            .updateloadingState(ButtonState.fail);
      }).whenComplete(() {
        final snackBarsuccess =
            SnackBar(content: Text('Votre compte à été éffacé'));
        ScaffoldMessenger.of(context).showSnackBar(snackBarsuccess);
        Provider.of<LoadingData>(context, listen: false)
            .updateloadingState(ButtonState.idle);
        signOut();
      });
    });
  }
}
