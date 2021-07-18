import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/closeButtonU.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/platformTextFieldForm.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:websafe_svg/websafe_svg.dart';

class TalkDialogBox extends StatefulWidget {
  const TalkDialogBox({
    Key key,
  }) : super(key: key);

  @override
  _TalkDialogBoxState createState() => _TalkDialogBoxState();
}

class _TalkDialogBoxState extends State<TalkDialogBox> {
  RxDouble _bottom = 5.0.h.obs;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      _bottom.value = 40.0.h;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExtendedContainer(
          height: 70.0.h,
          color: Colors.transparent,
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Stack(
                  children: [
                    ExtendedContainer(
                      margin: ConstPadMargin.talkBoxPadding,
                      width: double.infinity,
                      color: Color(0XFF020020),
                      // linearGradient: LinearGradient(
                      //   colors: [Color(0XFF41295a), Color(0XFF2F0743)],
                      //   end: Alignment.topCenter,
                      //   begin: Alignment.bottomCenter
                      // ),
                      height: 50.0.h,
                      personalizeBorderRadius:
                          BorderRadius.circular(SC.radiusCalculate(15.0.h)),
                      padding: EdgeInsets.symmetric(vertical: 1.15.h),
                      child: Obx(() => Stack(
                            children: [
                              AnimatedPositioned(
                                left: 0,
                                right: 0,
                                bottom: _bottom.value,
                                duration: Duration(seconds: 3),
                                onEnd: () async {
                                  if (_bottom.value == 5.0.h) {
                                    _bottom.value = 40.0.h;
                                  } else if (_bottom.value == 40.0.h) {
                                    _bottom.value = 5.0.h;
                                  }
                                },
                                child: ExtendedContainer(
                                  height: .250.h,
                                  margin: EdgeInsets.symmetric(vertical: 2.5.h),
                                  boxShadow: [Styles.backButtonShadow],
                                  linearGradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0XFFB22EF3),
                                        Color(0XFFB22EF3)
                                      ]),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 1.15.h),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Spacer(),
                                        CloseButtonU(
                                          onTap: () {
                                            Get.back();
                                          },
                                        )
                                      ],
                                    ),
                                    ExtendedContainer(
                                      shape: BoxShape.circle,
                                      padding: EdgeInsets.all(1.5.h),
                                      margin: EdgeInsets.only(bottom: 5.5.h),
                                      border:
                                          Border.all(color: Color(0XFF45108E)),
                                      color: Color(0XFF020020),
                                      child: Center(
                                        child: WebsafeSvg.asset(
                                            "assets/icon/smallMicrophone.svg",
                                            height: 3.5.h,
                                            color: Color(0XFF4A4A62)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                Positioned(
                  bottom: -3.85.h,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: ConstPadMargin.talkDisableButtonPadding,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 9.0),
                          child: PlatformTextFieldForm.textFieldPlatform(
                            title: 'Votre Réponse',
                            verticalContentPadding:
                                SizeCalculator.height(context, height: .0195),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SimpleButton(
                            title: "Valider",
                            whiteMode: true,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
