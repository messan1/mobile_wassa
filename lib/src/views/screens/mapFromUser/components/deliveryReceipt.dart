import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/simpleOrderCard.dart';
import 'package:ucolis/src/views/components/walletMoneyViewer.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:websafe_svg/websafe_svg.dart';

class DeliveryReceipt extends StatelessWidget {
  const DeliveryReceipt({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 1.5.h),
        child: ClipPath(
          clipper: ReceiptClip(),
          child: ExtendedContainer(
            color: whiteFont,
            boxShadow: [
              Styles.backButtonShadow
            ],
            child: Padding(
              padding: ConstPadMargin.listViewPadding,
              child: Column(
                  children: [
                    SizedBox(height: 5.5.h,),
                    ExtendedContainer(
                      color: greyFont.withOpacity(.45),
                      shape: BoxShape.circle,
                      border: Border.all(color: blackFont.withOpacity(.15)),
                      padding: EdgeInsets.all(3.5.h),
                      child: Center(
                        child: Icon(Icons.check, color: blackFont,),
                      ),
                    ),
                    SizedBox(height: 1.85.h,),
                    Text(ConstString.packageArrived, textAlign: TextAlign.center, style: Styles.ucolisGeneralBlackBoldFont.copyWith(fontSize: 17.0.sp),),
                    SizedBox(height: 1.85.h,),
                    SimpleOrderCard(
                      useShadowBox: false,
                      beginTime: "11:24",
                      endTime: "11:24",
                      startingPoint: "Ouagadougou, Burkina Faso aeroport",
                      deliveryPoint: "Cité air France",
                    ),
                    SizedBox(height: 1.0.h,),
                    ExtendedContainer(
                      personalizeBorderRadius: BorderRadius.circular(1.5.h),
                      color: greyFont,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.05.w, vertical: 1.95.h),
                        child: Row(
                            children:[
                              WebsafeSvg.asset("assets/icon/motor.svg", height: 4.5.h),
                              SizedBox(width: 2.5.w,),
                              Text(ConstString.account, style: Styles.ucolisGeneralBlackBoldFont.copyWith(fontWeight: FontWeight.w800),),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 2.95.w),
                                child: WalletMoneyViewer(color: blackFont,),
                              )
                            ]
                        ),
                      ),
                    )

                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReceiptClip extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

 Path _path = Path();
 _path.lineTo(0, size.height);
 var curXPos = 0.0;
 var curYPos = size.height;
 var increment = size.width / 24;
 while (curXPos < size.width) {
   curXPos += increment;
   curYPos = curYPos == size.height ? size.height - 10 : size.height;
   _path.lineTo(curXPos, curYPos);
 }
 _path.lineTo(size.width, 0);
 return _path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
   return true;
  }
  
}