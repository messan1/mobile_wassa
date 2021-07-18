import 'package:flutter/material.dart';
import 'package:ucolis/src/blocs/userBloc.dart';

import 'numericButton.dart';

class NumericButtonsGenerator extends StatelessWidget {
  const NumericButtonsGenerator({
    Key key,
    @required this.userBloc,
    @required this.isCode,
    @required this.numbers,
    this.orientation,
    this.actualRow,
  }) : super(key: key);

  final UserBloc userBloc;
  final bool isCode;
  final int numbers;
  final Orientation orientation;
  final int actualRow;

  @override
  Widget build(BuildContext context) {
    if (orientation == Orientation.portrait) {
      switch (actualRow) {
        case 0:
          return Row(
            children: List.generate(numbers, (index) {
              return NumericButton(
                  number: index + 1, userBloc: userBloc, isCode: isCode);
            }),
          );
          break;

        case 1:
          return Row(
            children: List.generate(numbers, (index) {
              return NumericButton(
                  number: 3 + (index + 1), userBloc: userBloc, isCode: isCode);
            }),
          );
          break;

        case 2:
          return Row(
            children: List.generate(numbers, (index) {
              return NumericButton(
                  number: 6 + (index + 1), userBloc: userBloc, isCode: isCode);
            }),
          );
          break;
      }
    } else {
      switch (actualRow) {
        case 0:
          return Row(
            children: List.generate(numbers, (index) {
              return NumericButton(
                  number: index + 1, userBloc: userBloc, isCode: isCode);
            }),
          );
          break;

        case 1:
          return Row(
            children: List.generate(numbers, (index) {
              return NumericButton(
                  number: 4 + (index + 1), userBloc: userBloc, isCode: isCode);
            }),
          );
          break;
      }
    }
    return Container();
  }
}
