import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/constants/constAudio.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/views/components/voiceCommand.dart';
import 'package:ucolis/src/views/screens/Auth/components/imageLoader.dart';

import 'components/languageButton.dart';

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
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
                  audio: data[1]
                      [Provider.of<VoiceData>(context, listen: false).langue],
                  close: false);
            }).then((value) {
          switch (Provider.of<VoiceData>(context, listen: false).reponse) {
            case 1:
              Provider.of<VoiceData>(context, listen: false).updateLangue('fr');
              Get.toNamed('/Login');
              break;
            case 2:
              Provider.of<VoiceData>(context, listen: false)
                  .updateLangue('more');
              Get.toNamed('/Login');
              break;
            case 3:
              Provider.of<VoiceData>(context, listen: false)
                  .updateLangue('dioula');
              Get.toNamed('/Login');
              break;
            case 4:
              Provider.of<VoiceData>(context, listen: false).updateLangue('en');
              Get.toNamed('/Login');
              break;
            default:
              Provider.of<VoiceData>(context, listen: false).updateLangue('fr');
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return ScaffoldPlatform(
      appBarTitle:
          Langue.appName[Provider.of<VoiceData>(context, listen: false).langue],
      activeBackButton: false,
      child: ListView(
        children: [
          SizedBox(
            height: _size.height * .43,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                  child: ImageLoader(image: "assets/images/limage3.png")),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LanguageButton(
                language: Langue
                    .fr[Provider.of<VoiceData>(context, listen: false).langue],
                countryCode: 'FR',
              ),
              LanguageButton(
                language: Langue.more[
                    Provider.of<VoiceData>(context, listen: false).langue],
                countryCode: 'BF',
              ),
              LanguageButton(
                language: Langue.dioula[
                    Provider.of<VoiceData>(context, listen: false).langue],
                countryCode: 'ML',
              ),
              LanguageButton(
                language: Langue
                    .en[Provider.of<VoiceData>(context, listen: false).langue],
                countryCode: 'US',
              ),
            ],
          )
        ],
      ),
    );
  }
}
