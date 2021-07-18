//import 'package:firebase_database/firebase_database.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/appData.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/Model/Adress.dart';
import 'package:ucolis/src/Model/NearByAvailabaleDriver.dart';
import 'package:ucolis/src/Model/PlacePrediction.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/constants/constAudio.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/utils/Assistance/RequestAssistance.dart';
import 'package:ucolis/src/utils/Assistance/geoFireAssistance.dart';
import 'package:ucolis/src/utils/ConfigMap.dart';
import 'package:ucolis/src/views/components/Map.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/components/voiceCommand.dart';
import 'package:ucolis/src/views/screens/dashboard/components/ucolisDrawer.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:ucolis/src/views/components/widget.dart';

class Destination extends StatefulWidget {
  const Destination({Key key}) : super(key: key);

  @override
  _DestinationState createState() => _DestinationState();
}

class _DestinationState extends State<Destination> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  Future _getThingsOnStartup() async {
    if (Provider.of<VoiceData>(context, listen: false).activercommandeVocal)
      playAudio();
    await Future.delayed(Duration(seconds: 30));
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
                  audio: data[10]
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
    for (String i in data[9]
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

  List<PlacePrediction> listplace = [];
  //final fb = FirebaseDatabase.instance;
  //final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    TextEditingController _postionController = new TextEditingController();
    TextEditingController _droffofController = new TextEditingController();
    _postionController.text = Provider.of<AppData>(context).pickupAdress == null
        ? ""
        : Provider.of<AppData>(context).pickupAdress.placeName;

    _droffofController.text =
        Provider.of<AppData>(context).dropOffadress == null
            ? ""
            : Provider.of<AppData>(context).dropOffadress.placeName;
    return ScaffoldPlatform(
        appBarTitle: Langue
            .destination[Provider.of<VoiceData>(context, listen: false).langue],
        drawer: UcolisDrawer(),
        child: Stack(
          children: [
            Positioned.fill(
              child: MapComponents(),
            ),
            Positioned(
              top: 17.0.h,
              left: 0,
              right: 0,
              child: ExtendedContainer(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: .2.h, horizontal: 5.0.w),
                personalizeBorderRadius: BorderRadius.circular(2.0.h),
                boxShadow: [Styles.littleShadow],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 19),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: StartEnd(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 70.0.w,
                              child: TextField(
                                controller: _postionController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    hintText: Langue.destination1[
                                        Provider.of<VoiceData>(context,
                                                listen: false)
                                            .langue]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1.0),
                              child: Container(
                                height: 1,
                                width: 70.0.w,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 70.0.w,
                              child: TextField(
                                //controller: _droffofController,
                                onChanged: (val) {
                                  findPlace(val);
                                },
                                onTap: () {
                                  setState(() {
                                    listplace = [];
                                  });
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    hintText: Langue.destination2[
                                        Provider.of<VoiceData>(context,
                                                listen: false)
                                            .langue]),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 55,
                left: 20,
                right: 20,
                child: (listplace.length > 0)
                    ? Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: ListView.separated(
                            padding: EdgeInsets.all(8.0),
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(),
                            itemCount: listplace.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return PredictionTile(
                                placePrediction: listplace[index],
                              );
                            },
                          ),
                        ),
                      )
                    : Container()),
            Positioned(
                bottom: 25,
                left: 20,
                right: 20,
                child: SimpleButton(
                  onTap: () => {},
                  title: Langue.next[
                      Provider.of<VoiceData>(context, listen: false).langue],
                ))
          ],
        ));
  }

  void findPlace(String placename) async {
    if (placename.length > 1) {
      String autocompledUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placename&key=$mapApi&sessiontoken=1234567890&components=country:ci";

      var response = await RequestAssistance.request(autocompledUrl);

      if (response == "failed") {
        return;
      }
      if (response["status"] == "OK") {
        var predictions = response["predictions"];

        var placeList = (predictions as List)
            .map((e) => PlacePrediction.fromJson(e))
            .toList();

        setState(() {
          listplace = placeList;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePrediction placePrediction;
  const PredictionTile({Key key, this.placePrediction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getPlaceDetailsApi(placePrediction.placeId, context);
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(height: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placePrediction.mainText,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        placePrediction.secondaryText,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getPlaceDetailsApi(String placeid, context) async {
    String placeurl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$mapApi";
    var response = await RequestAssistance.request(placeurl);

    if (response == "failed") {
      return;
    }
    if (response["status"] == "OK") {
      Adress adress = new Adress();
      adress.placeName = response["result"]["name"];

      adress.placeId = placeid;
      adress.longitude = response["result"]["geometry"]["location"]["lng"];
      adress.latitude = response["result"]["geometry"]["location"]["lat"];

      Provider.of<AppData>(context, listen: false).updateDropOffAdress(adress);
      Get.toNamed('/choixtype', arguments: "motor");
      //Navigator.pop(context, "obtainDirection");

    }
  }

  void initGeiFireListener(BuildContext context) {
    Geofire.initialize("availableDrivers");
    Geofire.queryAtLocation(
            Provider.of<AppData>(context).pickupAdress == null
                ? 0
                : Provider.of<AppData>(context).pickupAdress.latitude,
            Provider.of<AppData>(context).pickupAdress == null
                ? 0
                : Provider.of<AppData>(context).pickupAdress.longitude,
            15)
        .listen((map) {
      print(map);
      if (map != null) {
        var callBack = map['callBack'];

        switch (callBack) {
          case Geofire.onKeyEntered:
            NearByAvailabaleDriver nearByAvailabaleDriver =
                NearByAvailabaleDriver();

            nearByAvailabaleDriver.key = map["key"];
            nearByAvailabaleDriver.latitude = map["latitude"];
            nearByAvailabaleDriver.longitude = map["longitude"];

            GeoFireAssistance.nearByAvailabaleDriversList
                .add(nearByAvailabaleDriver);
            break;

          case Geofire.onKeyExited:
            GeoFireAssistance.removeDriver(map["key"]);
            break;

          case Geofire.onKeyMoved:
            NearByAvailabaleDriver nearByAvailabaleDriver =
                NearByAvailabaleDriver();

            nearByAvailabaleDriver.key = map["key"];
            nearByAvailabaleDriver.latitude = map["latitude"];
            nearByAvailabaleDriver.longitude = map["longitude"];
            GeoFireAssistance.updateDriverposition(nearByAvailabaleDriver);
            break;

          case Geofire.onGeoQueryReady:
            // All Intial Data is loaded
            print(map['result']);

            break;
        }
      }
    });
  }

  void upadetAvailableDriverOnMap() {}
}
