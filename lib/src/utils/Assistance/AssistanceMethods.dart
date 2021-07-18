import 'dart:math';

//import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/appData.dart';
import 'package:ucolis/src/Model/Adress.dart';
import 'package:ucolis/src/Model/DirectionDetails.dart';
import 'package:ucolis/src/Model/User.dart';
import 'package:ucolis/src/utils/ConfigMap.dart';

import 'RequestAssistance.dart';

class AssistanceMethode {
  static Future<String> SearchCoordonateAdrss(
      Position position, context) async {
    String placeAdress = "";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapApi";
    var response = await RequestAssistance.request(url);

    if (response != "failed") {
      placeAdress = response["results"][0]["formatted_address"];
      Adress userPickupAdress = new Adress();
      userPickupAdress.longitude = position.longitude;
      userPickupAdress.latitude = position.latitude;
      userPickupAdress.placeName = placeAdress;
      Provider.of<AppData>(context, listen: false)
          .updatePickupAdress(userPickupAdress);
    }
    return placeAdress;
  }

  static Future<DirectionDetails> obtainingDirection(
      LatLng initialPosition, LatLng finalPosition) async {
    String directionurl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapApi";
    var response = await RequestAssistance.request(directionurl);

    if (response == "failed") {
      return null;
    }

    DirectionDetails directionDetails = new DirectionDetails();

    directionDetails.encodePoints =
        response["routes"][0]["overview_polyline"]["points"];
    directionDetails.distanceValue =
        response["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.distanceText =
        response["routes"][0]["legs"][0]["distance"]["text"];

    directionDetails.durationText =
        response["routes"][0]["legs"][0]["duration"]["text"];

    directionDetails.durationValue =
        response["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }
/**
 * 
 *   static void getCurrentOnlineUserInfo() async {
    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child("123456785678");
    reference.once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot != null) {
        User users = User.fromSnapshot(dataSnapshot);
      }
    });
  }

 */

  static double createRandomNumber(int num) {
    var random = Random();
    int rand = random.nextInt(num);
    return rand.toDouble();
  }
}
