import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ucolis/src/services/auth.dart';
import 'package:ucolis/src/views/screens/dashboard/dashboard.dart';
import 'package:ucolis/src/views/screens/login/login.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = new AuthService();
    return Container();
  }
}
