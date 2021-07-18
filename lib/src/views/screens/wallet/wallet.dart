import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/constants/constAudio.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/components/voiceCommand.dart';
import 'package:ucolis/src/views/screens/wallet/components/deliveryResume.dart';
import 'package:ucolis/src/views/screens/wallet/components/paidTypeCard.dart';
import 'package:ucolis/src/views/screens/wallet/components/walletBottomSheet.dart';
import 'package:ucolis/src/views/screens/wallet/components/walletDashboard.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      if (Provider.of<VoiceData>(context, listen: false).activercommandeVocal) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return VoiceDialogBox(
                  audio: data[6]
                      [Provider.of<VoiceData>(context, listen: false).langue],
                  close: false);
            }).then((value) {
          switch (Provider.of<VoiceData>(context, listen: false).reponse) {
            case 1:
              Get.bottomSheet(WalletBottomSheet(), enableDrag: true);
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
        activeBackButton: true,
        child: Stack(
          children: [
            ExtendedContainer(
              height: 38.5.h,
              color: blackFont,
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topRight),
            ),
            SafeArea(
                child: ListView(
              children: [
                SizedBox(
                  height: 9.5.h,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                    child: Column(
                      children: [
                        WalletDashboard(),
                        PaidTypeCard(),
                        SizedBox(
                          height: 5.5.h,
                        ),
                        DeliveryResume(),
                        SizedBox(
                          height: 5.5.h,
                        ),
                        SimpleButton(
                          title: Langue.addMoney[
                              Provider.of<VoiceData>(context, listen: false)
                                  .langue],
                          onTap: () {
                            Get.bottomSheet(WalletBottomSheet(),
                                enableDrag: true);
                          },
                          normalCase: true,
                        )
                      ],
                    ))
              ],
            ))
          ],
        ));
  }
}
