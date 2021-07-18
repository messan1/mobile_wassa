import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/appData.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:flutter/material.dart';
import 'package:ucolis/src/constants/constAudio.dart';
import 'package:ucolis/src/views/components/Map.dart';
import 'package:ucolis/src/views/components/platformTextFieldForm.dart';
import 'package:ucolis/src/views/components/voiceCommand.dart';
import 'package:ucolis/src/views/screens/dashboard/components/walletTab.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class ChoixAdress extends StatefulWidget {
  const ChoixAdress({Key key}) : super(key: key);

  @override
  _ChoixAdressState createState() => _ChoixAdressState();
}

class _ChoixAdressState extends State<ChoixAdress> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  Future _getThingsOnStartup() async {
    playAudio();
    await Future.delayed(Duration(seconds: 20));
  }

  @override
  void initState() {
    setupPlaylist();
    _getThingsOnStartup().then((value) {
      if (Provider.of<VoiceData>(context, listen: false).activercommandeVocal) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return VoiceDialogBox(
                  audio: data[12]
                      [Provider.of<VoiceData>(context, listen: false).langue],
                  close: false);
            }).then((value) {
          /*switch (Provider.of<VoiceData>(context, listen: false).reponse) {
            case 1:
              //Cocher petit colis
              break;
            case 2:
              //Cocher moyen colis
              break;
            case 3:
              //Cocher gros colis
              break;
          }*/
        });
      }
    });
    super.initState();
  }

  void setupPlaylist() async {
    List<Audio> arr = [];
    for (String i in data[11]
        [Provider.of<VoiceData>(context, listen: false).langue]) {
      arr.add(Audio('assets/' + i));
    }
    audioPlayer.open(Playlist(audios: arr),
        showNotification: false, autoStart: true);
  }

  playAudio() async {
    await audioPlayer.play();
    audioPlayer.playlistFinished.listen((finished) {
      if (finished) {
        print("fini");
        //Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RxBool _addressIsSelected = false.obs;
    final String _vehicle = Get.arguments;
    ScrollController _controller = new ScrollController();

    final items = [
      'Horse',
      'Cow',
      'Camel',
      'Skljlhlkzheep',
      'Goat',
      'Horse',
      'Cowklhnklhqlks',
      'Camiuhigiel',
      'Sherrrrrrrep',
      'xxxxxxx'
    ];
    return ScaffoldPlatform(
      activeBackButton: true,
      appBarTitle:
          _addressIsSelected.value == false ? "" : "Choisir votre destination",
      appBarIconColor: Colors.red,
      child: Stack(
        children: [
          Positioned.fill(child: MapComponents()),
          Positioned(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  WalletTab(),
                  Stack(
                    children: [
                      Obx(
                        () => AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: _addressIsSelected.value == false
                              ? 47.5.h
                              : 100.0.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: whiteFont,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30..h)),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30..h)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _addressIsSelected.value == false
                                    ? ListView.separated(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        controller: _controller,
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                Divider(height: 2),
                                        itemCount: items.length,
                                        itemBuilder: (context, index) {
                                          if (index == 0) {
                                            _controller.animateTo(
                                              65.0,
                                              curve: Curves.easeOut,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            );
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.wb_sunny,
                                                  color: Colors.yellow[500],
                                                  size: 36,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Bonjour, Messan",
                                                  style: headerStyle,
                                                )
                                              ],
                                            );
                                          } else if (index == 1) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25, bottom: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.black38,
                                                  ),
                                                  Text("destination"),
                                                  Icon(Icons.edit)
                                                ],
                                              ),
                                            );
                                          } else if (index == 2) {
                                            if (_addressIsSelected.value ==
                                                false) {
                                              return GestureDetector(
                                                onTap: () {
                                                  _addressIsSelected
                                                              .value ==
                                                          false
                                                      ? _addressIsSelected
                                                          .toggle()
                                                      : _addressIsSelected
                                                          .toggle();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, bottom: 20),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .my_location_rounded,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          "Entrez le lieu de destination",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20..sp),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, bottom: 20),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.my_location_rounded,
                                                      color: Colors.blueAccent,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: PlatformTextFieldForm
                                                          .textFieldPlatform(
                                                              title:
                                                                  'Mot de passe',
                                                              verticalContentPadding:
                                                                  SizeCalculator
                                                                      .height(
                                                                          context,
                                                                          height:
                                                                              .0175),
                                                              controller: null),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 20),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.home,
                                                  color: Colors.black,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    items[index],
                                                    style: messageHomeStyle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        })
                                    : Container(),
                              )),
                        ),
                      ),
                    ],
                  )
                ]),
            bottom: 0,
            left: 0,
            right: 0,
          ),
        ],
      ),
    );
  }
}
