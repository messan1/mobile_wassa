import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/chooseAdressData.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/screens/dashboard/components/packageType.dart';
import 'package:ucolis/src/views/screens/dashboard/components/selectedAddressCard.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:websafe_svg/websafe_svg.dart';

class OrderParms extends StatelessWidget {
  const OrderParms({
    Key key, @required this.vehicle,
  }) : super(key: key);
  final String vehicle;

  static get _motor => "motor";


  @override
  Widget build(BuildContext context) {
    RxInt _group = 0.obs;
    return Column(
      children: [
        Padding(
          padding: ConstPadMargin.listViewPadding,
          child: SelectedAddressCard(),
        ),
        Padding(
          padding: ConstPadMargin.listViewPadding,
          child: _addAddressButton,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: List.generate(3, (index) => PackageType(selected: index, group: _group, onPressed: (){
                _group.value = index;
              }, vehicle: vehicle,),
              ),
            ),
          ),
        ),
        ExtendedContainer(
          width: double.infinity,
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.5.h),
          boxShadow: [
            Styles.backButtonShadow
          ],
          personalizeBorderRadius: BorderRadius.circular(2.5.h),
          child: MaterialInkWell(
            onPressed: (){},
            radius: 2.5.h,
            child: Padding(
              padding: EdgeInsets.all(2.5.h),

              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Obx (()=>Text(data[_group.value]['type'], style: Styles.ucolisGeneralBlackBoldFont,)) 
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 3.0.w, left: 1.75.w),
                        child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 15.0.w
                            ),
                            child:Obx (()=>WebsafeSvg.asset(data[_group.value]['image'], height: 8.75.h)),) 
                      ),
                      Flexible(
                        child:Obx(()=>Text.rich(TextSpan(text: data[_group.value]['question'], style: TextStyle(color: blackFont, fontSize: 10.0.sp), children: [
                          TextSpan(text: data[_group.value]['caracteristique1']),
                          TextSpan(text: data[_group.value]['caracteristique1']),
                        ]), 
                        overflow: TextOverflow.ellipsis,)),
                      )
                    ],
                  ),
                  SizedBox(height: 1.75.h,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget get _addAddressButton {
    return ExtendedContainer(
      color: Colors.white,
      personalizeBorderRadius: BorderRadius.circular(1.75.h),
      child: MaterialInkWell(
        onPressed: () {},
        radius: 1.75.h,
        child: Padding(
          padding: EdgeInsets.all(1.75.h),
          child: Row(
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                color: blueFont,
              ),
              SizedBox(
                width: 1.5.w,
              ),
              Text(
                ConstString.addAddress,
                style: Styles.ucolisGeneralBlackBoldFont.copyWith(color: blueFont),
              )
            ],
          ),
        ),
      ),
    );
  }
}
