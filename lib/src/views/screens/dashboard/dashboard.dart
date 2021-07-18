import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/constants/constAudio.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/menuButton.dart';
import 'package:ucolis/src/views/components/voiceCommand.dart';
import 'package:ucolis/src/views/screens/dashboard/components/dashOptionTab.dart';
import 'package:ucolis/src/views/screens/dashboard/components/dashSlider.dart';
import 'package:ucolis/src/views/screens/dashboard/components/ucolisDrawer.dart';
import 'package:ucolis/src/views/screens/dashboard/components/walletTab.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final storage = new FlutterSecureStorage();
  static get _motor => "motor";
  static get _cars => "cars";
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
                  audio: data[5]
                      [Provider.of<VoiceData>(context, listen: false).langue],
                  close: false);
            }).then((value) {
          switch (Provider.of<VoiceData>(context, listen: false).reponse) {
            case 1:
              Get.toNamed("/destination", arguments: _motor);
              break;
            case 2:
              Get.toNamed("/choixAdress", arguments: _cars);
              break;
            case 3:
              Get.toNamed("/wallet");
              break;
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
        drawer: UcolisDrawer(),
        scaffoldState: _drawerKey,
        leading: MenuButton(
          onPressed: () => _drawerKey.currentState.openDrawer(),
        ),
        appBarTitle: Langue
            .appName[Provider.of<VoiceData>(context, listen: false).langue],
        titleColor: whiteFont,
        child: Stack(
          children: [
            Positioned.fill(
                child: ExtendedImage.asset(
              "assets/images/background.png",
              fit: BoxFit.fill,
            )),
            DashSlider(),
            Positioned(
              bottom: 36.0.h,
              right: 0,
              child: Image.asset(
                "assets/images/image1.png",
                fit: BoxFit.fill,
                scale: 1.08,
              ),
            ),
            Positioned(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    WalletTab(),
                    DashOptionTab(),
                  ]),
              bottom: 0,
              left: 0,
              right: 0,
            ),
          ],
        ));
  }
}
