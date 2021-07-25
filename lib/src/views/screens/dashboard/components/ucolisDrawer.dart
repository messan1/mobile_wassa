import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/userAuth.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/Endpoint.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/services/auth.dart';
import 'package:ucolis/src/services/dbservice.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/profilePicture.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class UcolisDrawer extends StatelessWidget {
  final String profilrPicture;

  const UcolisDrawer({Key key, this.profilrPicture}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String imagePath = 'assets/profile.jpg';
    AuthService auth = AuthService();
    UserDBservice db = UserDBservice();

    return Drawer(
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: blackFont,
                padding: EdgeInsets.only(left: 8.0.w, top: 10.0.h),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: blackFont),
                  accountName: FutureBuilder(
                      future: db.getUserInformation(),
                      builder: (context, AsyncSnapshot snap) {
                        if (snap.hasData) {
                          return Text(
                            snap.data["firstname"],
                            style: nameMenuStyle,
                          );
                        }
                        if (snap.hasError) {
                          return Text("Something went wrong");
                        }

                        return Container();
                      }),
                  accountEmail: Text(
                    auth.getUser.email ?? 'null@null.com',
                    style: mailMenuStyle,
                  ),
                  currentAccountPicture: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/profile");
                        },
                        child: FutureBuilder(
                            future: db.getUserInformation(),
                            builder: (context, AsyncSnapshot snap) {
                              if (snap.hasData) {
                                return ProfilePicture(
                                    profilePicture: FirebaseStorageImage +
                                        snap.data["profile"] +
                                        "?alt=media",
                                    drawer: true,
                                    radius: 6.75.h);
                              }
                              return ProfilePicture(
                                  profilePicture: null,
                                  radius: 60.0.h,
                                  drawer: true);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              _drawerButton(
                  onTap: () => Get.toNamed("/historic"),
                  title: Langue.histo[
                      Provider.of<VoiceData>(context, listen: false).langue]),
              _drawerButton(
                  onTap: () => Get.toNamed("/wallet"),
                  title: Langue.wallet[
                      Provider.of<VoiceData>(context, listen: false).langue]),
              _drawerButton(
                  onTap: () => Get.toNamed("/promo"),
                  title: Langue.promo[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  length: 2),
              _drawerButton(
                  onTap: () => Get.toNamed("/support"),
                  title: Langue.support[
                      Provider.of<VoiceData>(context, listen: false).langue]),
              _drawerButton(
                  onTap: () => Get.toNamed("/mapFromDeliver"),
                  title: Langue.testdev[
                      Provider.of<VoiceData>(context, listen: false).langue]),
            ],
          ),
          Positioned(
            child: GestureDetector(
              onTap: () {
                auth.signOut();
              },
              child: ExtendedContainer(
                padding: EdgeInsets.only(left: 13.0.w, bottom: 15, top: 15),
                width: SC.width(),
                child: Text(
                  Langue.decon[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  style: linkStyle,
                ),
              ),
            ),
            bottom: 3.0.h,
          ),
        ],
      ),
    );
  }
}

Widget _drawerButton({Function onTap, String title, int length}) {
  return InkWell(
    onTap: onTap,
    child: ListTile(
      title: Padding(
        padding: EdgeInsets.only(left: 8.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: componentMenuStyle,
            ),
          ],
        ),
      ),
      trailing: length != null
          ? ExtendedContainer(
              boxShadow: [Styles.littleShadow],
              color: Colors.white,
              shape: BoxShape.circle,
              height: 5.0.h,
              width: 5.0.h,
              child: Center(
                  child: Text(
                length.toString(),
                style: componentMenuStyle,
              )),
            )
          : Container(
              height: 0,
              width: 0,
            ),
    ),
  );
}
