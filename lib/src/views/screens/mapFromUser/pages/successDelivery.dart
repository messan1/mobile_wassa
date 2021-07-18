import 'package:flutter/cupertino.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/screens/mapFromUser/components/deliveryReceipt.dart';

class SuccessDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
      activeBackButton: true,
      backgroundColor: Colors.grey.shade100,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DeliveryReceipt(),
              SizedBox(height: 4.5.h,),
              SimpleButton(
                title: "Ok",
                normalCase: true,
                onTap: (){},
              ),
              SizedBox(height: 2.5.h,),

            ],
          ),
        ),
      ),

    );
  }
}


