import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class WalletMoneyViewer extends StatelessWidget {
  const WalletMoneyViewer({
    Key key,
    this.color,
    this.price,
  }) : super(key: key);
  final Color color;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Text(
          price ?? "50.000",
          style: color == null ? moneyStyle : moneyStyle.copyWith(color: color),
          textAlign: TextAlign.center,
        ),
        Positioned(
            right: -13
              ..sp,
            top: -3
              ..sp,
            child: Text(
              "Frs",
              style: color == null
                  ? moneyStyle.copyWith(fontSize: 10..sp)
                  : moneyStyle.copyWith(fontSize: 10..sp, color: color),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
