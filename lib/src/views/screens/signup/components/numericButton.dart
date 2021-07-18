import 'package:flutter/material.dart';
import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/views/screens/Auth/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/screens/styles/styles.dart';

class NumericButton extends StatelessWidget {
  const NumericButton({
    Key key,
    @required this.number,
    @required this.userBloc,
    @required this.isCode,
  }) : super(key: key);
  final int number;
  final UserBloc userBloc;
  final bool isCode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder<String>(
            stream: isCode == true ? userBloc.smsCode : userBloc.phone,
            builder: (context, snapshot) {
              return ExtendedContainer(
                personalizeBorderRadius: BorderRadius.circular(15),
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      userBloc.getPhoneOrCode(isCode: isCode, number: number);
                      print('This SnapShot infinity ${snapshot.data}');
                    },
                    child: Padding(
                      padding: EdgeInsets.all(
                          SizeCalculator.height(context, height: .025)),
                      child: Text(
                        number.toString(),
                        textScaleFactor: 1.35,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: blackFont, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
