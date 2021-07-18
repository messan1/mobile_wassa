import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/Map.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/Search/SearchScreen.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class AddAddressCard extends StatelessWidget {
  const AddAddressCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _dropOffController = new TextEditingController();
    TextEditingController _positionController = new TextEditingController();
    return ExtendedContainer(
      margin: EdgeInsets.only(top: 2.5.h, bottom: 1.25.h),
      personalizeBorderRadius: BorderRadius.circular(2.5.h),
      height: 14.95.h,
      padding: EdgeInsets.all(2.5.h),
      color: Colors.white,
      boxShadow: [Styles.backButtonShadow],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.35.w),
            child: Column(
              children: [
                ExtendedContainer(
                  color: blueFont,
                  height: 1.0.h,
                  width: 1.0.h,
                  shape: BoxShape.circle,
                ),
                ExtendedContainer(
                  height: 8.0.h,
                  width: .5.w,
                  color: blackFont,
                ),
                Flexible(
                  child: Icon(
                    Icons.arrow_drop_down_sharp,
                    color: blackFont,
                  ),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Votre Position",
                style: Styles.ucolisGeneralBlackBoldFont,
              ),
              Expanded(
                  child: Divider(
                thickness: 1.35,
              )),
              Text(
                "Destination",
                style: Styles.ucolisGeneralBlackBoldFont,
              ),
            ],
          )
        ],
      ),
    );
  }
}
