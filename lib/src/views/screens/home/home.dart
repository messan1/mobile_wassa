import 'package:flutter/material.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService auth = AuthService();

  @override
  void initState() {
    print(auth.getUser);
    if (auth.getUser != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container();
          });
      auth.authPersistchecker(auth.getUser.uid,context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
      activeBackButton: false,
      appBarTitle: "",
      child: Container(),
    );
  }
}

//  buildVoiceDialog(context);
