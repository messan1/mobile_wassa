import 'package:get/get.dart';
import 'package:ucolis/src/app/Endpoint.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constSize.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/services/auth.dart';

import 'package:ucolis/src/services/dbservice.dart';
import 'package:ucolis/src/views/components/profilePicture.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/components/simpleButtonLoading.dart';
import 'package:ucolis/src/views/screens/profile/components/informationBox.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:g_skeleton/g_skeleton.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserDBservice db = UserDBservice();
    AuthService auth = new AuthService();
    final controller = SkeletonController(end: CupertinoColors.activeOrange);


    final increasing = UniqueKey();

    return ScaffoldPlatform(
        appBarIconColor: Colors.black,
        key: increasing,
        activeBackButton: true,
        child: SafeArea(
          child: ListView(
            padding: ConstPadMargin.listViewPadding,
            children: [
              SizedBox(height: ConstSize.safeAreaListView),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder(
                      future: db.getUserInformation(),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          return Column(
                            children: [
                              ProfilePicture(
                                  profilePicture: FirebaseStorageImage +
                                      snap.data["profile"] +
                                      "?alt=media",
                                  radius: 6.75.h),
                              SizedBox(height: 3),
                              Text(
                                auth.getUser.displayName
                                    .split(" ")[0]
                                    .toUpperCase(),
                                style: nameMenuStyle.copyWith(color: blackFont),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              InformationBox(
                                email: snap.data["email"],
                                fullname:
                                    auth.getUser.displayName.toUpperCase(),
                                phone: snap.data["phone"],
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            Container(
                              height: 3.5.h,
                              width: 3.5.h,
                            ),
                            SizedBox(height: 3),
                            Text(
                              "null".toUpperCase(),
                              style: nameMenuStyle.copyWith(color: blackFont),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            InformationBox(
                              email: '',
                              fullname: '',
                              phone: '',
                            ),
                          ],
                        );
                      }),
                ],
              ),
              SizedBox(
                height: 1.0.h,
              ),
              SwitchListTile(
                value: false,
                onChanged: (value) {},
                title: Text(ConstString.notifications),
                subtitle: Text(ConstString.receiNotifications),
              ),
              SizedBox(
                height: 1.75.h,
              ),
                   SimpleButtonLoading(
                    color: redFont,
                  title: ConstString.delAccount,
                    onTap: () => {
                          db.auth.deleteAccount(
                              context,)
                        },
                    state: null),
       
              SizedBox(
                height: 2.5.h,
              ),
              SimpleButton(
                title: ConstString.changeAccount,
                
                onTap: () {
                 Get.toNamed("/AccountType");
                },
              ),
              SizedBox(
                height: 2.0.h,
              ),
            ],
          ),
        ));
  }
}
