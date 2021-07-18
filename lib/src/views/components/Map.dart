import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/appData.dart';
import 'package:ucolis/src/utils/Assistance/AssistanceMethods.dart';

class MapComponents extends StatefulWidget {
  const MapComponents(
      {Key key,
      this.zoom = 14,
      this.tilf = 0,
      this.leading = 0,
      this.circlesSet,
      this.markersSet,
      this.latubound})
      : super(key: key);
  final double zoom;
  final double tilf;
  final double leading;
  final LatLngBounds latubound;
  final Set<Marker> markersSet;
  final Set<Circle> circlesSet;

  @override
  _MapComponentsState createState() => _MapComponentsState(
      zoom: zoom,
      leading: leading,
      tilf: tilf,
      latubound: this.latubound,
      circlesSet: this.circlesSet,
      markersSet: this.markersSet);
}

class _MapComponentsState extends State<MapComponents> {
  _MapComponentsState({
    this.zoom = 14,
    this.tilf = 0,
    this.leading = 0,
    this.latubound = null,
    this.circlesSet = null,
    this.markersSet = null,
  });
  final double zoom;
  final double tilf;
  final double leading;
  final LatLngBounds latubound;
  final Set<Marker> markersSet;
  final Set<Circle> circlesSet;

  Completer<GoogleMapController> _controllerMap = Completer();
  GoogleMapController newcontroller;
  Position currentPosition;
  var markers = new HashSet<Marker>();

  var geolocator = Geolocator();
  double bottomPadding = 0;

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latposition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(
        target: latposition,
        zoom: this.zoom,
        tilt: this.tilf,
        bearing: this.leading);

    newcontroller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String adress =
        await AssistanceMethode.SearchCoordonateAdrss(position, context);
    print("adresse:" + adress);

    newcontroller
        .animateCamera(CameraUpdate.newLatLngBounds(this.latubound, 70));
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(5.359952, -4.008256),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        padding: EdgeInsets.only(bottom: bottomPadding),
        mapType: MapType.normal,
        myLocationEnabled: true,
        polylines: Provider.of<AppData>(context, listen: false).polyset,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        markers: this.markersSet == null ? {} : this.markersSet,
        circles: this.circlesSet == null ? {} : this.circlesSet,
        onMapCreated: (GoogleMapController controller) {
          _controllerMap.complete(controller);
          newcontroller = controller;

          setState(() {
            bottomPadding = 340.0;
          });
          getLocation();
        },
        initialCameraPosition: _kGooglePlex);
  }
}
