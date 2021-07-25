import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ucolis/src/services/auth.dart';

class UserDBservice {
  CollectionReference users =
      FirebaseFirestore.instance.collection('users_data');
  AuthService auth = AuthService();

  Future<dynamic> getUserInformation() async {
    if (auth.getUser != null) {
      return users.doc(auth.getUser.uid).get();
    }
    return null;
  }
}
