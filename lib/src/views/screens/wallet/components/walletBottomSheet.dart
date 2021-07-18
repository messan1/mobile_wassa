import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constAudio.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/components/voiceCommand.dart';
import 'package:ucolis/src/views/screens/wallet/components/rechargeOperatorCard.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:get/get.dart';

class WalletBottomSheet extends StatefulWidget {
  const WalletBottomSheet({
    Key key,
  }) : super(key: key);
  @override
  _WalletBottomSheetState createState() => _WalletBottomSheetState();
}

class _WalletBottomSheetState extends State<WalletBottomSheet> {
  RxBool _isVisible = false.obs;
  RxString _selectedOperator = "".obs;
  RxInt _sum = 0.obs;
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

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
                  audio: data[7]
                      [Provider.of<VoiceData>(context, listen: false).langue],
                  close: false);
            }).then((value) {
          switch (Provider.of<VoiceData>(context, listen: false).reponse) {
            case 1:
              _isVisible.toggle();
              _selectedOperator.value = "Orange Money";
              break;
            case 2:
              _isVisible.toggle();
              _selectedOperator.value = "Orange Money";
              break;
            case 3:
              _isVisible.toggle();
              _selectedOperator.value = "Carte bancaire";
              break;
          }
          setupPlaylist();
          playAudio();
        });
      }
    });
    super.initState();
  }

  void setupPlaylist() async {
    audioPlayer.open(
        Playlist(audios: [
          Audio("assets/" +
              data[8][Provider.of<VoiceData>(context, listen: false).langue][0])
        ]),
        showNotification: false,
        autoStart: true);
  }

  playAudio() async {
    await audioPlayer.play();
    audioPlayer.playlistFinished.listen((finished) {
      if (finished) {
        //Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      color: whiteFont,
      height: 45.5.h,
      personalizeBorderRadius:
          BorderRadius.vertical(top: Radius.circular(30..h)),
      child: Stack(
        children: [
          Positioned.fill(
              child:
                  _selectOperatorCard(_isVisible, _selectedOperator, context)),
          Obx(
            () => Positioned.fill(
              child: _sumToAdd(
                _isVisible,
                _selectedOperator.value,
                _sum.value.toString(),
                context,
                add: () => _sum += 500,
                minus: () => (_sum > 0) ? _sum -= 500 : null,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _sumToAdd(
      RxBool isVisible, String selectedOperator, String sum, context,
      {Function add, Function minus}) {
    bool _paidMode = selectedOperator.toLowerCase().contains("bancaire");
    return Visibility(
      visible: isVisible.value,
      child: ExtendedContainer(
        personalizeBorderRadius:
            BorderRadius.vertical(top: Radius.circular(30..h)),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: ConstPadMargin.listViewPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ExtendedContainer(
                  height: 5..h,
                  width: 30..w,
                  margin: EdgeInsets.only(top: 10, bottom: 2.5.h),
                  useBorderRadius: true,
                  color: Colors.blueGrey.withOpacity(.35),
                ),
                Text(
                  selectedOperator,
                  style: TextStyle(
                      color: greyFont,
                      fontWeight: FontWeight.w900,
                      fontSize: 15.0.sp),
                ),
                SizedBox(
                  height: 3.5.h,
                ),
                Text(
                  Langue.enterSum[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  style: TextStyle(
                      color: blackFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0.sp),
                ),
                SizedBox(
                  height: 4.5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _addMinusWalletButton(
                        icon: Icons.remove_circle_outline_rounded,
                        onPressed: minus),
                    Text.rich(
                      TextSpan(
                          text: sum,
                          style: moneyStyle.copyWith(fontSize: 25.0.sp),
                          children: [
                            TextSpan(
                                text: "\nFCFA",
                                style: TextStyle(
                                    color: blackFont,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0.sp))
                          ]),
                      textAlign: TextAlign.center,
                    ),
                    _addMinusWalletButton(
                      icon: Icons.add_circle_outline_rounded,
                      onPressed: add,
                    )
                  ],
                ),
                SizedBox(
                  height: 5.5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: SimpleButton(
                          title: Langue.annuler[
                              Provider.of<VoiceData>(context, listen: false)
                                  .langue],
                          onTap: () {
                            isVisible.toggle();
                          },
                          whiteMode: true,
                        ),
                      ),
                      SizedBox(
                        width: 4.5.w,
                      ),
                      Expanded(
                          child: SimpleButton(
                        title: Langue.valider[
                            Provider.of<VoiceData>(context, listen: false)
                                .langue],
                        onTap: () {
                          Get.toNamed(
                              "/recharge?operator=$selectedOperator&paidMode=$_paidMode&sum=$sum");
                        },
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.5.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectOperatorCard(
      RxBool isVisible, RxString selectedOperator, context) {
    return ExtendedContainer(
      color: Colors.white,
      personalizeBorderRadius:
          BorderRadius.vertical(top: Radius.circular(30..h)),
      child: SingleChildScrollView(
        child: Padding(
          padding: ConstPadMargin.listViewPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ExtendedContainer(
                height: 5..h,
                width: 30..w,
                margin: EdgeInsets.only(top: 10, bottom: 2.5.h),
                useBorderRadius: true,
                color: Colors.blueGrey.withOpacity(.35),
              ),
              Text(
                Langue.paidMethod[
                    Provider.of<VoiceData>(context, listen: false).langue],
                style: TextStyle(
                    color: blackFont,
                    fontWeight: FontWeight.w900,
                    fontSize: 15.0.sp),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              /* RechargeOperatorCard(
                color: Colors.red,
                operator: "Airtel Money",
                onPressed: () {
                  isVisible.toggle();
                  selectedOperator.value = "Airtel Money";
                },
              ),*/
              RechargeOperatorCard(
                color: Colors.deepOrange,
                operator: "Orange Money",
                onPressed: () {
                  isVisible.toggle();
                  selectedOperator.value = "Orange Money";
                },
              ),
              RechargeOperatorCard(
                color: Colors.blue,
                operator: Langue.paidBank[
                    Provider.of<VoiceData>(context, listen: false).langue],
                onPressed: () {
                  isVisible.toggle();
                  selectedOperator.value = "Carte bancaire";
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addMinusWalletButton(
      {@required Function onPressed, @required IconData icon}) {
    return ExtendedContainer(
      height: 7.5.h,
      width: 7.5.h,
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [Styles.backButtonShadow],
      child: MaterialInkWell(
        onPressed: onPressed,
        customBorder: CircleBorder(),
        child: Center(
          child: Icon(
            icon,
            color: blueFont,
          ),
        ),
      ),
    );
  }
}
