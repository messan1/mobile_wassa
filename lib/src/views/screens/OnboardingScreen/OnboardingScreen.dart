import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constAudio.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/utils/Assistance/AuthAssistanceMethods.dart';
import 'package:ucolis/src/views/components/voiceCommand.dart';
import 'package:ucolis/src/views/screens/language/language.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numofpage = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentpage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numofpage; i++) {
      list.add(i == _currentpage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  _showError(msg) {
    EasyLoading.showError(msg);
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.instance.animationStyle = EasyLoadingAnimationStyle.opacity;
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.pulse;
  }

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
                  audio: data[0]
                      [Provider.of<VoiceData>(context, listen: false).langue],
                  close: false);
            });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF3E2AD1),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 607,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentpage = page;
                      });
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image(
                                image: AssetImage("assets/images/onboard1.png"),
                                height: 300,
                                width: 300,
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              Langue.ob1[
                                  Provider.of<VoiceData>(context, listen: false)
                                      .langue],
                              style: kTitleStyle,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              Langue.ob2[
                                  Provider.of<VoiceData>(context, listen: false)
                                      .langue],
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image(
                                image: AssetImage("assets/images/onboard2.png"),
                                height: 300,
                                width: 300,
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              Langue.ob3[
                                  Provider.of<VoiceData>(context, listen: false)
                                      .langue],
                              style: kTitleStyle,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              Langue.ob4[
                                  Provider.of<VoiceData>(context, listen: false)
                                      .langue],
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image(
                                image: AssetImage("assets/images/onboard3.png"),
                                height: 300,
                                width: 300,
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              Langue.ob5[
                                  Provider.of<VoiceData>(context, listen: false)
                                      .langue],
                              style: kTitleStyle,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              Langue.ob6[
                                  Provider.of<VoiceData>(context, listen: false)
                                      .langue],
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                Spacer(),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Center(
                        child: Text(
                            Langue.ob7[
                                Provider.of<VoiceData>(context, listen: false)
                                    .langue],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0))),
                  ),
                  onTap: () async {
                    /* if (await Permission.location.isPermanentlyDenied |
                        await Permission.photos.isPermanentlyDenied |
                        await Permission.storage.isPermanentlyDenied) {
                      openAppSettings();
                    }

                    Map<Permission, PermissionStatus> statuses = await [
                      Permission.location,
                      Permission.photos,
                      Permission.storage,
                    ].request();

                    if (statuses[Permission.location].isPermanentlyDenied |
                        statuses[Permission.storage].isPermanentlyDenied |
                        statuses[Permission.photos].isPermanentlyDenied) {
                      openAppSettings();
                    }
                    if (statuses[Permission.location].isDenied |
                        statuses[Permission.storage].isDenied |
                        statuses[Permission.photos].isDenied) {
                      _showError(Langue.ob8[
                          Provider.of<VoiceData>(context, listen: false)
                              .langue]);
                    }
                    if (statuses[Permission.location].isGranted &&
                        statuses[Permission.storage].isGranted &&
                        statuses[Permission.photos].isGranted) {
                      Get.offAll(Login());
                    } */
                    //Get.offAll(Login());
                    switch (Provider.of<VoiceData>(context, listen: false)
                        .reponse) {
                      case 1:
                        Provider.of<VoiceData>(context, listen: false)
                            .updateActiverCommandeVocal(true);
                        break;
                      case 2:
                        Provider.of<VoiceData>(context, listen: false)
                            .updateActiverCommandeVocal(false);
                        break;
                      default:
                        Provider.of<VoiceData>(context, listen: false)
                            .updateActiverCommandeVocal(true);
                    }
                    Get.offAll(Language());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
