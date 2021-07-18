import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/components/walletMoneyViewer.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class WalletTab extends StatelessWidget {
  const WalletTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 30.0.w),
      personalizeBorderRadius: BorderRadius.circular(2.0.h),
      boxShadow: [Styles.littleShadow],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: MaterialInkWell(
          onPressed: () => Get.toNamed("/wallet"),
          radius: 2.0.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                Langue.wallet[
                    Provider.of<VoiceData>(context, listen: false).langue],
                style: prixMessageStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3,
              ),
              WalletMoneyViewer(
                color: Color(0xff1152FD),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
