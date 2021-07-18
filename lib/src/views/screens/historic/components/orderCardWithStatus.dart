import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class OrderCardWithStatus extends StatelessWidget {
  const OrderCardWithStatus({
    Key key,
    @required this.date,
    this.status,
    @required this.beginTime,
    @required this.endTime,
    @required this.startingPoint,
    @required this.deliveryPoint,
  }) : super(key: key);
  final String date;
  final bool status;
  final String beginTime;
  final String endTime;
  final String startingPoint;
  final String deliveryPoint;

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 3.5.h),
      personalizeBorderRadius: BorderRadius.circular(2.75.h),
      boxShadow: [Styles.backButtonShadow],
      child: MaterialInkWell(
        radius: 2.75.h,
        onPressed: () => Get.toNamed("/courseDetail"),
        child: Padding(
          padding: EdgeInsets.all(4.5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date),
                  Text(
                    status == true
                        ? Langue.termine[
                                Provider.of<VoiceData>(context, listen: false)
                                    .langue]
                            .toUpperCase()
                        : Langue.annule[
                                Provider.of<VoiceData>(context, listen: false)
                                    .langue]
                            .toUpperCase(),
                    style: status == true ? endStatusStyle : cancelStatusStyle,
                  )
                ],
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  ExtendedContainer(
                    height: 12.85.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(beginTime),
                        Text(endTime),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  Column(
                    children: [
                      ExtendedContainer(
                        color: blackFont,
                        height: 1.0.h,
                        width: 1.0.h,
                        shape: BoxShape.circle,
                      ),
                      ExtendedContainer(
                        height: 10.5.h,
                        width: .5.w,
                        color: blackFont,
                      ),
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        color: blackFont,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  Expanded(
                    child: ExtendedContainer(
                      height: 13.0.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ExtendedContainer(
                            child: Text(
                              startingPoint,
                              style: Styles.ucolisGeneralBlackBoldFont,
                            ),
                          ),
                          ExtendedContainer(
                            child: Text(
                              deliveryPoint,
                              style: Styles.ucolisGeneralBlackBoldFont,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3.5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
