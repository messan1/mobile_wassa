import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucolis/src/views/screens/mapFromUser/components/circleButton.dart';


class PhoneMessageAndCancelCard extends StatelessWidget {
  const PhoneMessageAndCancelCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleButton(icon: Icons.call, onPressed: (){},),
            CircleButton(icon: Icons.message_outlined, onPressed: (){}, useLightMode:  true, length: 10,),
            CircleButton(icon: Icons.close, onPressed: (){Get.toNamed("/cancelDelivery");}, useLightMode: true,),
          ],),
      ],
    );
  }
}
