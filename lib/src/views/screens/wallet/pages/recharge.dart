import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/buttonWithArrow.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/platformTextFieldForm.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/screens/wallet/components/rechargeInstructionCard.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class Recharge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool _paidMode = Get.parameters["paidMode"].toLowerCase() == "true";
    final String _sum = Get.parameters["sum"];
    final String _operator = Get.parameters["operator"];
    print("Paid mode = $_paidMode");
    return ScaffoldPlatform(
        activeBackButton: true,
        appBarTitle: Langue
            .wallet[Provider.of<VoiceData>(context, listen: false).langue],
        child: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: ConstPadMargin.listViewPadding,
                children: [
                  SizedBox(height: 3.5.h),
                  ButtonWithArrow(
                      arrowDirection: Icons.keyboard_arrow_down_rounded,
                      onPressed: () {},
                      normalCase: true,
                      title: _paidMode == true
                          ? ConstString.chargeWCard
                          : ConstString.chargeMM(_operator)),
                  SizedBox(height: 2.5.h),
                  ExtendedContainer(
                    color: Colors.white,
                    personalizeBorderRadius: BorderRadius.circular(2.65.h),
                    padding: EdgeInsets.all(2.35.h),
                    boxShadow: [Styles.backButtonShadow],
                    child: RechargeInstructionCard(
                      sum: _sum,
                      instructions: _paidMode == true
                          ? ConstString.cardRechargeInstruction
                          : ConstString.mobileRechargeInstruction,
                    ),
                  ),
                  SizedBox(height: 2.5.h),
                  _paidMode == true ? _cardPaidField : _mobileMoneyField,
                  SizedBox(height: _paidMode == true ? 16.95.h : 5.5.h)
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
                  height: 12.0.h,
                  child: SimpleButton(
                    title: Langue.confPaid[
                        Provider.of<VoiceData>(context, listen: false).langue],
                    onTap: () {},
                    color: blueFont,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget get _cardPaidField {
    return Column(
      children: List.generate(
        ConstString.cardPaidField.length,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 2.5.h),
          child: PlatformTextFieldForm.textFieldPlatform(
            title: ConstString.cardPaidField[index],
            isPassword:
                index == ConstString.cardPaidField.length - 1 ? true : false,
            suffix: index == ConstString.cardPaidField.length - 2
                ? _suffixCalendar
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ),
        ),
      ),
    );
  }

  Widget get _suffixCalendar {
    return IconButton(
      icon: Icon(
        GetPlatform.isIOS
            ? CupertinoIcons.calendar
            : Icons.calendar_today_rounded,
        color: blackFont,
      ),
      onPressed: () {},
    );
  }

  Widget get _mobileMoneyField {
    return Column(
      children: List.generate(
        ConstString.mobileMoneyField.length,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 2.5.h),
          child: PlatformTextFieldForm.textFieldPlatform(
              title: ConstString.mobileMoneyField[index],
              isPassword: index == ConstString.mobileMoneyField.length - 1
                  ? true
                  : false),
        ),
      ),
    );
  }
}
