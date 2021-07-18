import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/loadingData.dart';
import 'package:ucolis/src/DataHandler/userAuth.dart';
import 'package:ucolis/src/views/screens/Auth/components/buildShowDialog.dart';

class DbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Updates the User's data in Firestore on each new login
  Future<void> updateUserData(User user) {
    DocumentReference reportRef = _db.collection('users_data').doc(user.uid);

    return reportRef.set({'uid': user.uid, 'lastActivity': DateTime.now()},
        SetOptions(merge: true));
  }

  Future<void> uploadProfile(File imageFile) async {
    File _imageFile;

    Future uploadImageToFirebase(BuildContext context) async {
      FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instanceFor(app: secondaryApp);
    }
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
                updateUserInfoData(context, name),
                Provider.of<LoadingData>(context, listen: false)
                    .updateloadingState(ButtonState.idle)
              });
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> updateUserEmailData(context) {
    String userUuuid = Provider.of<UserAuth>(context, listen: false).useruuid;
    DocumentReference reportRef = _db.collection('users_data').doc(userUuuid);

    return reportRef.set({
      'uid': userUuuid,
      'lastActivity': DateTime.now(),
      'email': Provider.of<UserAuth>(context, listen: false).email,
      'accountType': Provider.of<UserAuth>(context, listen: false).role,
    }, SetOptions(merge: true));
  }

  Future<void> updateUserInfoData(context, String profile) {
    String userUuuid = Provider.of<UserAuth>(context, listen: false).useruuid;
    DocumentReference reportRef = _db.collection('users_data').doc(userUuuid);

    reportRef.set({
      'uid': userUuuid,
      'profile': profile,
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
      Get.toNamed('/AddDocument');
    }
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
}
