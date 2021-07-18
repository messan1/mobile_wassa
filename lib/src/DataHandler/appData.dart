import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ucolis/src/Model/Adress.dart';
import 'package:ucolis/src/Model/RiderOnlineState.dart';
import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  Adress pickupAdress, dropOffadress;
  Set<Polyline> polyset = {};
  RiderOnlineState riderOnlineState = new RiderOnlineState();
  String id;

  void updatePickupAdress(Adress pickupadress) {
    pickupAdress = pickupadress;
    notifyListeners();
  }

  void updateId(String _id) {
    id = _id;
    notifyListeners();
  }

  void updatePolySet(Set<Polyline> setpoly) {
    polyset = setpoly;
    notifyListeners();
  }

  void updateDropOffAdress(Adress drop) {
    dropOffadress = drop;
    notifyListeners();
  }

  void updateRiderOnlineState(bool state) {
    RiderOnlineState datariderOnlineState = new RiderOnlineState();
    datariderOnlineState.isOnline = state;

    if (state == true) {
      datariderOnlineState.text = "Vous êtes en ligne";
      datariderOnlineState.color = Colors.green;
    } else {
      datariderOnlineState.text = "Voute êtes en hors ligne";
      datariderOnlineState.color = Colors.black;
    }
    riderOnlineState = datariderOnlineState;

    notifyListeners();
  }
}
