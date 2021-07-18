import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

  Future<void> uploadFile(File imageFile) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/file-to-upload.png')
          .putFile(imageFile);
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }
}
