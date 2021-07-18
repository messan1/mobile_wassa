import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';


class Dialog extends StatefulWidget {
  final IconData arrowDirection;
  final Function onPressed;
  final String title;
  final bool normalCase;
  final bool rotateArrow;
  final AnimationController controller;

  const Dialog(
      {Key key,
      this.arrowDirection,
      this.onPressed,
      this.title,
      this.normalCase,
      this.rotateArrow,
      this.controller})
      : super(key: key);

  @override
  _DialogState createState() => _DialogState(this.arrowDirection,
      this.onPressed, this.title, this.normalCase, this.controller);
}

class _DialogState extends State<Dialog> with SingleTickerProviderStateMixin {
  final IconData arrowDirection;
  final Function onPressed;
  final String title;
  final bool normalCase;
  final AnimationController controller;

  _DialogState(this.arrowDirection, this.onPressed, this.title, this.normalCase,
      this.controller);
  @override
  Widget build(BuildContext context) {
            AwesomeDialog(
            context: context,
            title: "Vérification de Données",
            desc: "Vérifiez vos données de connexion",
            dialogType: DialogType.ERROR,
            width: SizeCalculator.height(context, height: .45),
            animType: AnimType.SCALE,
            btnOkColor: Colors.redAccent,
            btnOkOnPress: () {}
            )
          ..show();
    return null;
  }
}
