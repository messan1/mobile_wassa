import 'package:flutter/material.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class ThereAreOrderCard extends StatelessWidget {
  const ThereAreOrderCard({
    Key key, this.onDetailsPressed,
  }) : super(key: key);
  final Function onDetailsPressed;
  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: Text(ConstString.nearFromDelivery, style: Styles.ucolisGeneralBlackBoldFont,),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: SimpleButton(title: ConstString.details, onTap: onDetailsPressed)),
            SizedBox(
              width: 3.5.w,
            ),
            Expanded(child: SimpleButton(title: ConstString.cancel, onTap: (){}, whiteMode: true,)),

          ],
        )
      ],
    );
  }
}
