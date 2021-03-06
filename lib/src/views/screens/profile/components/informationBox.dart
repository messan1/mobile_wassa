import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class InformationBox extends StatelessWidget {
  const InformationBox(
      {Key key,
      @required this.phone,
      @required this.email,
    
      @required this.fullname})
      : super(key: key);

  final String phone;
  final String email;

  final String fullname;

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 1.25.h, vertical: 2.0.h),
      personalizeBorderRadius: BorderRadius.circular(3.5.h),
      boxShadow: [Styles.backButtonShadow],
      child: Column(
        children: [
          SizedBox(height: 1.75.h),
          profileInfoBox(title: phone),
          profileInfoBox(title: email),
          profileInfoBox(title: fullname, icon: Icons.person_outline_rounded),

          profileInfoBox(
              title: ConstString.changeLanguage,
              icon: Icons.flag_outlined,
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onPresse: () {
                //Get.dialog(ChangeLangageDialog());
                Get.toNamed("/Language");
              }),
        ],
      ),
    );
  }

  Widget profileInfoBox(
      {@required String title,
      IconData icon,
      Widget trailing,
      Function onPresse}) {
    return InkWell(
      onTap: onPresse == null ? null : onPresse,
      child: ExtendedContainer(
        margin: EdgeInsets.only(left: 13.0.w, right: 5.0.w, bottom: 1.75.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: componentMenuStyle,
                ),
                trailing != null ? trailing : SizedBox(width: 0)
              ],
            ),
            Stack(
              overflow: Overflow.visible,
              children: [
                Divider(),
                icon != null
                    ? Positioned(
                        child: Icon(
                          icon,
                          color: blackFont,
                          size: 4.0.h,
                        ),
                        bottom: 5..h,
                        left: -10.0.w,
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
