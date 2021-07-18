import 'package:flutter/material.dart';
import 'package:ucolis/src/views/screens/signup/components/inputForNumber.dart';

class InputForPhoneNumber extends StatelessWidget {
  const InputForPhoneNumber({
    Key key,
    @required this.phone,
    @required this.inputLength,
  }) : super(key: key);

  final String phone;
  final int inputLength;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(inputLength ?? 1, (index) {
        return InputForNumber(
            phone: phone != null && phone.length >= index + 1
                ? phone.substring(index, index + 1)
                : "");
      }),
    );
  }
}
