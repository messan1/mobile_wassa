import 'package:flutter/material.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/views/screens/Auth/components/buildVoiceDialog.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
      activeBackButton: false,
      appBarTitle: "",
      child: Center(
          child: GestureDetector(
              onTap: () => {buildVoiceDialog(context)},
              child: Text("Commencer votre aventure"))),
    );
  }
}

//  buildVoiceDialog(context);
