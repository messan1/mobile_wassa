import 'package:flutter/material.dart';

import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/views/screens/Auth/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/screens/styles/styles.dart';

class CheckButton extends StatefulWidget {
  const CheckButton({
    Key key,
    @required this.isCode,
    @required this.userBloc,
  }) : super(key: key);
  final bool isCode;
  final UserBloc userBloc;

  @override
  _CheckButtonState createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  bool isValid = false;

  @override
  void initState() {
    if (widget.isCode == true) {
      widget.userBloc.smsCode.listen((code) {
        if (code.length == 6) {
          isValid = true;
          print('helloo ' + code);
        } else {
          isValid = false;
        }
      });
    } else {
      widget.userBloc.phone.listen((phone) {
        if (phone.length == 8) {
          isValid = true;
        } else {
          isValid = false;
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ExtendedContainer(
      personalizeBorderRadius: BorderRadius.circular(15),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: StreamBuilder<String>(
          stream: widget.isCode == true
              ? widget.userBloc.smsCode
              : widget.userBloc.phone,
          builder: (context, snapshot) {
            return Material(
              borderRadius: BorderRadius.circular(15),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () async {
                  widget.userBloc.phone.listen((phone) {
                    if (phone.length == 8) {}
                  });
                  widget.userBloc
                      .verifyPhoneOrCode(context, isCode: widget.isCode);
                },
                child: Padding(
                  padding: EdgeInsets.all(
                      SizeCalculator.height(context, height: .025)),
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      color: isValid ? blueFont : greyFont,
                    ),
                  ),
                ),
              ),
            );
          }),
    ));
  }
}
