import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/appData.dart';

import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:flutter/material.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/utils/Assistance/AssistanceMethods.dart';
import 'package:ucolis/src/views/components/Map.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';

import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class ChoixAdress extends StatefulWidget {
  @override
  _ChoixAdressState createState() => _ChoixAdressState();
}

class _ChoixAdressState extends State<ChoixAdress> {
  List<LatLng> plineCoordonate = [];
  Set<Polyline> polyset = {};
  ScrollController _controller = new ScrollController();
  RxBool _nextpage = false.obs;

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
  @override
  Widget build(BuildContext context) {
    final String _vehicle = Get.arguments;
    return ScaffoldPlatform(
      activeBackButton: true,
      child: Stack(
        children: [
          Positioned.fill(child: MapComponents()),
          Positioned(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: _nextpage.value == false ? 50.5.h : 97.5.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: whiteFont,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30..h)),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
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
                                      duration:
                                          const Duration(milliseconds: 300),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.black38,
                                          ),
                                          Text(""),
                                          Icon(Icons.edit)
                                        ],
                                      ),
                                    );
                                  } else if (index == 2) {
                                    return GestureDetector(
                                      onTap: () {
                                        _nextpage.value == false
                                            ? _nextpage.toggle()
                                            : _nextpage.toggle();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.my_location_rounded,
                                              color: Colors.blueAccent,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "Entrez le lieu de destination",
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20..sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
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
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            items[index],
                                            style: messageHomeStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ExtendedContainer(
                            padding: ConstPadMargin.listViewPadding,
                            alignment: Alignment.center,
                            color: whiteFont,
                            height: 10.5.h,
                            child: SimpleButton(
                              title: ConstString.next,
                              normalCase: true,
                              onTap: () => Get.toNamed('/chooseType',
                                  arguments: _vehicle),
                            )),
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

  Column item({title, subtitle}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.access_alarm_outlined),
          title: Text(
            title,
            style: TextStyle(fontSize: 22, color: Colors.black54),
          ),
          subtitle: Text(subtitle,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade400)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Divider(
            height: 0,
            thickness: 1.5,
          ),
        ),
      ],
    );
  }

  Future<void> getDirection() async {
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

      Provider.of<AppData>(context, listen: false).updatePolySet(polyset);
    }
  }
}
