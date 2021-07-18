import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constSize.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/profilePicture.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/screens/profile/components/informationBox.dart';
import 'package:ucolis/src/views/styles/styles.dart';


class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
      appBarIconColor: Colors.black,
        activeBackButton: true,
        child: SafeArea(
          child: ListView(
            padding: ConstPadMargin.listViewPadding,
            children: [
          SizedBox(height: ConstSize.safeAreaListView),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfilePicture(imagePath: "imagePath", radius: 6.75.h,),
              SizedBox(height: 3),
              Text("LaVigne".toUpperCase(), style: nameMenuStyle.copyWith(color: blackFont),),
            ],
          ),
          SizedBox(height: 1.5.h,),
          InformationBox(),
          SizedBox(height: 1.0.h,),
          SwitchListTile(value: false, onChanged: (value){
          }, title: Text(ConstString.notifications), subtitle: Text(ConstString.receiNotifications),),
          SizedBox(height: 1.75.h,),

          SimpleButton(title: ConstString.delAccount, onTap: (){

          }, color: redFont,),
          SizedBox(height: 2.5.h,),
          SimpleButton(title: ConstString.changeAccount, onTap: (){

          },),
          SizedBox(height: 2.0.h,),

      ],
    ),
        ));
  }
}