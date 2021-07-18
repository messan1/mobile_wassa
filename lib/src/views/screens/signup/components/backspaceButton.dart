import 'package:flutter/material.dart';
import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/views/screens/Auth/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/screens/styles/styles.dart';

class BackspaceButton extends StatelessWidget {
  final UserBloc userBloc;
  final bool isCode;
  const BackspaceButton({Key key, @required this.userBloc, this.isCode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ExtendedContainer(
      personalizeBorderRadius: BorderRadius.circular(15),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            userBloc.backspace(isCode: isCode);
          },
          child: Padding(
            padding:
                EdgeInsets.all(SizeCalculator.height(context, height: .025)),
            child: Center(
              child: Icon(
                Icons.backspace_rounded,
                color: greyFont,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
