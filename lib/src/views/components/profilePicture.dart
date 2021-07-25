import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key key,
    this.profilePicture,
    this.imagePath,
    this.radius,
    this.drawer,
    this.withEditButton,
  }) : super(key: key);

  final String profilePicture;
  final String imagePath;
  final bool drawer;
  final double radius;
  final withEditButton;

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      overflow: Overflow.visible,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: radius,
          backgroundImage: profilePicture == null
              ? AssetImage("assets/profile.jpg")
              : ExtendedNetworkImageProvider(profilePicture),
          child: imagePath == null
              ? Icon(
                  Icons.person,
                  color: Colors.transparent,
                )
              : Text(''),
        ),
        withEditButton == false
            ? Container()
            : Positioned(
                right: -1.0.w,
                top: -.085.h,
                child: ExtendedContainer(
                  height: 3.5.h,
                  width: 3.5.h,
                  color: greyFont,
                  shape: BoxShape.circle,
                  child: MaterialInkWell(
                      onPressed: () {
                        if (drawer == true) {
                          Get.toNamed("/profile");
                        } else {
                          Get.toNamed("/UpdateUserInfo");
                        }
                      },
                      customBorder: CircleBorder(),
                      child: Icon(
                        Icons.edit_outlined,
                        size: 2.3.h,
                      )),
                ),
              ),
      ],
    );
  }
}
