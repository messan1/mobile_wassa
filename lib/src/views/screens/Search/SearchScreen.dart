import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/appData.dart';
import 'package:ucolis/src/Model/Adress.dart';
import 'package:ucolis/src/Model/PlacePrediction.dart';
import 'package:ucolis/src/utils/Assistance/RequestAssistance.dart';
import 'package:ucolis/src/utils/ConfigMap.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickupcontroller = new TextEditingController();
  TextEditingController dropoffController = new TextEditingController();
  List<PlacePrediction> listplace = [];
  @override
  Widget build(BuildContext context) {
    String placeAdress =
        Provider.of<AppData>(context).pickupAdress.placeName ?? "";

    pickupcontroller.text = placeAdress;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 240.0,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 6,
                  spreadRadius: 0.7,
                  offset: Offset(0.7, 0.7))
            ]),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Stack(
                    children: [
                      TextField(
                        controller: pickupcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Pickup",
                            labelStyle: TextStyle(fontSize: 12.0),
                            hintStyle: TextStyle(fontSize: 10.0)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      TextField(
                        onChanged: (val) {
                          findPlace(val);
                        },
                        controller: dropoffController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Where To",
                            labelStyle: TextStyle(fontSize: 12.0),
                            hintStyle: TextStyle(fontSize: 10.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          (listplace.length > 0)
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListView.separated(
                    padding: EdgeInsets.all(8.0),
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: listplace.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PredictionTile(
                        placePrediction: listplace[index],
                      );
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
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
    return FlatButton(
      padding: EdgeInsets.all(12.0),
      onPressed: () {
        getPlaceDetailsApi(placePrediction.placeId, context);
      },
      child: Container(
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
      print(response["result"]["name"]);

      return;
    }
    if (response["status"] == "OK") {
      Adress adress = new Adress();
      adress.placeName = response["result"]["name"];
      adress.placeId = placeid;
      adress.longitude = response["result"]["geometry"]["location"]["lng"];
      adress.latitude = response["result"]["geometry"]["location"]["lat"];

      print(adress.latitude);

      Provider.of<AppData>(context, listen: false).updateDropOffAdress(adress);

      Navigator.pop(context, "obtainDirection");
    }
  }
}
