import 'package:flutter/material.dart';
import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';

import 'backspaceButton.dart';
import 'checkButton.dart';
import 'numericButton.dart';
import 'numericButtonGenerator.dart';

class NumericPad extends StatelessWidget {
  final Orientation orientation;
  final UserBloc userBloc;
  final bool isCode;

  const NumericPad(
      {Key key, this.orientation, this.userBloc, @required this.isCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeCalculator.width(context, width: .11)),
      child: orientation == Orientation.portrait
          ? Column(
              children: [
                Column(
                  children: List.generate(
                    3,
                    (index) => NumericButtonsGenerator(
                      userBloc: userBloc,
                      isCode: isCode,
                      numbers: 3,
                      orientation: orientation,
                      actualRow: index,
                    ),
                  ),
                ),
                Row(
                  children: [
                    CheckButton(isCode: isCode, userBloc: userBloc),
                    NumericButton(
                        number: 0, isCode: isCode, userBloc: userBloc),
                    BackspaceButton(isCode: isCode, userBloc: userBloc)
                  ],
                ),
              ],
            )
          : Column(
              children: [
                Column(
                  children: List.generate(
                    2,
                    (index) => NumericButtonsGenerator(
                      userBloc: userBloc,
                      isCode: isCode,
                      numbers: 4,
                      actualRow: index,
                    ),
                  ),
                ),
                Row(
                  children: [
                    NumericButton(
                        number: 9, isCode: isCode, userBloc: userBloc),
                    NumericButton(
                        number: 0, isCode: isCode, userBloc: userBloc),
                    CheckButton(isCode: isCode, userBloc: userBloc),
                    BackspaceButton(isCode: isCode, userBloc: userBloc)
                  ],
                ),
              ],
            ),
    );
  }
}
