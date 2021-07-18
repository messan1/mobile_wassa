//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/appData.dart';
import 'package:ucolis/src/Model/NearByAvailabaleDriver.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:flutter/material.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/utils/Assistance/AssistanceMethods.dart';
import 'package:ucolis/src/utils/Assistance/geoFireAssistance.dart';
import 'package:ucolis/src/views/components/Map.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/screens/dashboard/components/orderParms.dart';
import 'package:ucolis/src/views/screens/dashboard/components/orderValidate.dart';
import 'package:ucolis/src/views/screens/dashboard/components/paidModeBox.dart';
import 'package:ucolis/src/views/screens/dashboard/components/walletTab.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class ChooseType extends StatefulWidget {
  @override
  _ChooseTypeState createState() => _ChooseTypeState();
}

class _ChooseTypeState extends State<ChooseType> {
  List<LatLng> plineCoordonate = [];
  Set<Polyline> polyset = {};
  RxBool _addressIsSelected = false.obs;
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  LatLngBounds latLngBounds;
  GoogleMapController newcontroller;
  BitmapDescriptor customIcon;
  BitmapDescriptor dropcustomIcon;
  BitmapDescriptor moto;
  bool nearbykeyloaded = false;

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/icon/ic_pick.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  createMotoMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/icon/moto.png')
          .then((icon) {
        setState(() {
          moto = icon;
        });
      });
    }
  }

  dropcreateMarker(context) {
    if (dropcustomIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
              configuration, 'assets/icon/ic_dropoff.png')
          .then((icon) {
        setState(() {
          dropcustomIcon = icon;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //AssistanceMethode.getCurrentOnlineUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    dropcreateMarker(context);
    createMotoMarker(context);
    final String _vehicle = Get.arguments != null ? Get.arguments : "motor";
    return ScaffoldPlatform(
      activeBackButton: true,
      appBarTitle: "Choisir Votre Colis",
      child: Stack(
        children: [
          Positioned.fill(
              child: _addressIsSelected.value == false
                  ? Image.asset(
                      "assets/map.jpg",
                      fit: BoxFit.cover,
                    )
                  : MapComponents(
                      zoom: 15,
                      leading: 16,
                      tilf: 5,
                      markersSet: this.markersSet,
                      circlesSet: this.circlesSet,
                      latubound: this.latLngBounds,
                    )),
          Positioned(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  WalletTab(),
                  Stack(
                    children: [
                      Obx(() => AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            height: _addressIsSelected.value == false
                                ? 75.5.h
                                : 30.5.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: whiteFont,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30..h)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30..h)),
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ExtendedContainer(
                                        height: 5..h,
                                        width: 30..w,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 1.05.h),
                                        useBorderRadius: true,
                                        color: _addressIsSelected.value == false
                                            ? Colors.blueGrey.withOpacity(.35)
                                            : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                  _addressIsSelected.value == false
                                      ? OrderParms(vehicle: _vehicle)
                                      : OrderValidate(vehicle: _vehicle),
                                  SizedBox(
                                    height: 13.0.h,
                                  )
                                ],
                              ),
                            ),
                          )),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ExtendedContainer(
                          padding: ConstPadMargin.listViewPadding,
                          alignment: Alignment.center,
                          color: whiteFont,
                          height: 10.5.h,
                          child: Obx(() => SimpleButton(
                                title: _addressIsSelected.value == false
                                    ? ConstString.next
                                    : ConstString.reserve,
                                normalCase: true,
                                onTap: _addressIsSelected.value == false
                                    // ignore: sdk_version_set_literal
                                    ? () => {
                                          getDirection(context),
                                        }
                                    : () => Get.dialog(
                                        PaidModeBox(vehicle: _vehicle)),
                              )),
                        ),
                      )
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

  Future<void> getDirection(context) async {
    initGeiFireListener(context);
    //createData();
    _addressIsSelected.toggle();

    var initailpos = Provider.of<AppData>(context, listen: false).pickupAdress;
    var dropoff = Provider.of<AppData>(context, listen: false).dropOffadress;

    var pickupLong = LatLng(initailpos.latitude, initailpos.longitude);
    var dropoffLong = LatLng(dropoff.latitude, dropoff.longitude);

    var details =
        await AssistanceMethode.obtainingDirection(pickupLong, dropoffLong);

    print("Geo Point " + details.encodePoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodepolylinepoint =
        polylinePoints.decodePolyline(details.encodePoints);

    if (decodepolylinepoint.isNotEmpty) {
      decodepolylinepoint.forEach((PointLatLng pointlat) {
        plineCoordonate.add(LatLng(pointlat.latitude, pointlat.longitude));
      });
      polyset = {};

      setState(() {
        Polyline polyline = Polyline(
            color: Colors.black,
            polylineId: PolylineId("ID"),
            jointType: JointType.round,
            startCap: Cap.roundCap,
            width: 5,
            points: plineCoordonate,
            endCap: Cap.roundCap,
            geodesic: true);
        polyset.add(polyline);
      });

      if (pickupLong.latitude > dropoffLong.latitude &&
          pickupLong.longitude > dropoffLong.longitude) {
        latLngBounds =
            LatLngBounds(southwest: dropoffLong, northeast: pickupLong);
      } else if (pickupLong.longitude > dropoffLong.longitude) {
        latLngBounds = LatLngBounds(
            southwest: LatLng(pickupLong.latitude, dropoffLong.longitude),
            northeast: LatLng(dropoffLong.latitude, pickupLong.longitude));
      } else if (pickupLong.latitude > dropoffLong.latitude) {
        latLngBounds = LatLngBounds(
            southwest: LatLng(dropoffLong.latitude, pickupLong.longitude),
            northeast: LatLng(pickupLong.latitude, dropoffLong.longitude));
      } else {
        latLngBounds =
            LatLngBounds(southwest: pickupLong, northeast: dropoffLong);
      }
      Provider.of<AppData>(context, listen: false).updatePolySet(polyset);

      Marker pickmarker = Marker(
          icon: customIcon,
          infoWindow:
              InfoWindow(title: initailpos.placeName, snippet: "Ma position"),
          position: pickupLong,
          markerId: MarkerId("pickup"));

      Marker dropfmarker = Marker(
          icon: dropcustomIcon,
          infoWindow:
              InfoWindow(title: dropoff.placeName, snippet: "Ma destination"),
          position: dropoffLong,
          markerId: MarkerId("dropoff"));

      setState(() {
        markersSet.add(pickmarker);
        markersSet.add(dropfmarker);
      });
    }
  }

  void initGeiFireListener(BuildContext context) {
    Geofire.initialize("availableDrivers");
    Geofire.queryAtLocation(
            Provider.of<AppData>(context, listen: false).pickupAdress == null
                ? 0
                : Provider.of<AppData>(context, listen: false)
                    .pickupAdress
                    .latitude,
            Provider.of<AppData>(context, listen: false).pickupAdress == null
                ? 0
                : Provider.of<AppData>(context, listen: false)
                    .pickupAdress
                    .longitude,
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

            if (nearbykeyloaded == true) {
              upadetAvailableDriverOnMap();
            }
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
            upadetAvailableDriverOnMap();

            break;
        }
      }
    });
  }

  void upadetAvailableDriverOnMap() {
    Set<Marker> tmarkers = Set<Marker>();

    for (NearByAvailabaleDriver driver
        in GeoFireAssistance.nearByAvailabaleDriversList) {
      LatLng driverAvailablePosition =
          LatLng(driver.latitude, driver.longitude);

      Marker marker = Marker(
          icon: moto,
          rotation: AssistanceMethode.createRandomNumber(160),
          position: driverAvailablePosition,
          markerId: MarkerId(driver.key));

      setState(() {
        markersSet.add(marker);
      });
    }
  }
}
