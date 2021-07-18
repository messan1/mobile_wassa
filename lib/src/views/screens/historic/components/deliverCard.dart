import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class DeliverCard extends StatelessWidget {
  const DeliverCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        ExtendedContainer(
          alignment: Alignment.center,
          color: Colors.white,
          height: 16.0.h,
          personalizeBorderRadius: BorderRadius.circular(2.75.h),
          boxShadow: [Styles.backButtonShadow],
          child: MaterialInkWell(
            radius: 2.75.h,
            onPressed: () {
              Get.toNamed("/deliverInfo");
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 1.5.h),
              child: Row(
                children: [
                  ExtendedContainer(
                    personalizeBorderRadius: BorderRadius.circular(6.75.h),
                    margin: EdgeInsets.only(right: 6),
                    width: 24.0.w,
                    height: 12.0.h,
                    image: DecorationImage(
                        image: AssetImage("assets/profile.jpg"),
                        fit: BoxFit.fill),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                            text: "Messan",
                            style: nameDetailStyle,
                            children: [
                              TextSpan(
                                  text: "\nVolkswagen Jetta",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12.0.sp))
                            ]),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 3.0.h,
                          ),
                          SizedBox(width: 5),
                          Text('4.8',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.0.sp))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          child: Icon(
            Icons.arrow_forward_ios,
            color: blackFont.withOpacity(.7),
            size: 2.0.h,
          ),
          right: 3.5.w,
          top: 0,
          bottom: 0,
        )
      ],
    );
  }
}
