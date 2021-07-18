import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/DataHandler/appData.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class SelectedAddressCard extends StatelessWidget {
  const SelectedAddressCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      margin: EdgeInsets.only(top: 2.5.h, bottom: 1.25.h),
      personalizeBorderRadius: BorderRadius.circular(2.5.h),
      height: 14.95.h,
      padding: EdgeInsets.all(2.5.h),
      color: Colors.white,
      boxShadow: [Styles.backButtonShadow],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.35.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ExtendedContainer(
                  color: blueFont,
                  height: 1.0.h,
                  width: 1.0.h,
                  shape: BoxShape.circle,
                ),
                ExtendedContainer(
                  height: 7.85.h,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Provider.of<AppData>(context).pickupAdress == null
                      ? ""
                      : Provider.of<AppData>(context)
                          .pickupAdress
                          .placeName
                          .toUpperCase(),
                  style: Styles.ucolisGeneralBlackBoldFont,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                    child: Divider(
                  thickness: 1.35,
                )),
                Text(
                  Provider.of<AppData>(context).dropOffadress == null
                      ? ""
                      : Provider.of<AppData>(context)
                          .dropOffadress
                          .placeName
                          .toUpperCase(),
                  style: Styles.ucolisGeneralBlackBoldFont,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
