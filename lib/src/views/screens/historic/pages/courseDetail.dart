import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/components/simpleOrderCard.dart';
import 'package:ucolis/src/views/components/walletMoneyViewer.dart';
import 'package:ucolis/src/views/screens/historic/components/deliverCard.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class CourseDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
        appBarTitle: Langue
            .detcourse[Provider.of<VoiceData>(context, listen: false).langue],
        activeBackButton: true,
        child: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      ExtendedContainer(
                        height: 30.5.h,
                        color: Colors.blueGrey,
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: -18.5.h,
                          child: Padding(
                            padding: ConstPadMargin.listViewPadding,
                            child: SimpleOrderCard(
                              beginTime: "11:24",
                              endTime: "11:24",
                              startingPoint:
                                  "Ouagadougou, Burkina Faso aeroport",
                              deliveryPoint: "Cité air France",
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 18.0.h,
                  ),
                  Padding(
                    padding: ConstPadMargin.listViewPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          Langue.type2[
                              Provider.of<VoiceData>(context, listen: false)
                                  .langue],
                          style: nameDetailStyle,
                        ),
                        SizedBox(height: 1.0.h),
                        DeliverCard(),
                        SizedBox(height: 3.0.h),
                        Text(
                          Langue.paidMethod[
                              Provider.of<VoiceData>(context, listen: false)
                                  .langue],
                          style: nameDetailStyle,
                        ),
                        SizedBox(height: 1.0.h),
                        PaidMethodCard()
                      ],
                    ),
                  ),
                  SizedBox(height: 16.95.h)
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ExtendedContainer(
                  padding: ConstPadMargin.listViewPadding,
                  alignment: Alignment.center,
                  color: whiteFont,
                  boxShadow: [Styles.backButtonShadow],
                  height: 12.95.h,
                  child: SimpleButton(
                    title: Langue.report[
                        Provider.of<VoiceData>(context, listen: false).langue],
                    normalCase: true,
                    onTap: () {},
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class PaidMethodCard extends StatelessWidget {
  const PaidMethodCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      alignment: Alignment.center,
      color: greyFont.withOpacity(.7),
      height: 8.5.h,
      personalizeBorderRadius: BorderRadius.circular(2.5.h),
      child: MaterialInkWell(
        radius: 2.75.h,
        onPressed: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 1.5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ExtendedContainer(
                personalizeBorderRadius: BorderRadius.circular(1.75.h),
                width: 5.0.h,
                height: 5.0.h,
                color: Colors.deepOrange,
              ),
              Padding(
                padding: EdgeInsets.only(right: 5.0.w),
                child: WalletMoneyViewer(
                  color: blackFont,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
