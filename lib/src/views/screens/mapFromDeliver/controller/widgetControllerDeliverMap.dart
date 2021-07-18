import 'dart:async';

//import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/appData.dart';
import 'package:ucolis/src/Model/Adress.dart';
import 'package:ucolis/src/Model/AuthState.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/constants/enum.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/screens/dashboard/components/orderValidate.dart';
import 'package:ucolis/src/views/screens/mapFromDeliver/components/thereAreOrderCard.dart';
import 'package:ucolis/src/views/styles/styles.dart';

abstract class WidgetControllerDeliverMap {
  // ignore: missing_return
  static double bottomSheetHeightDependOnStep({@required DeliverSteps steps}) {
    switch (steps) {
      case DeliverSteps.SEARCHING:
        return 0;
        break;
      case DeliverSteps.THERE_ARE_ORDER:
        return 30.5.h;
        break;
      case DeliverSteps.ORDER_DETAIL:
        return 50.0.h;
        break;
      case DeliverSteps.DELIVERING:
        return 30.5.h;
        break;
      case DeliverSteps.WAITING:
        return 35.5.h;
        break;
    }
  }

  // ignore: missing_return
  static double myLocationButtonPositionDependOnStep(
      {@required DeliverSteps steps}) {
    switch (steps) {
      case DeliverSteps.WAITING:
        return 5.0.h;
        break;
      case DeliverSteps.SEARCHING:
        return 5.0.h;
        break;
      case DeliverSteps.THERE_ARE_ORDER:
        return 35.0.h;
        break;
      case DeliverSteps.ORDER_DETAIL:
        return 5.0.h;
        break;
      case DeliverSteps.DELIVERING:
        return 35.0.h;

        break;
    }
  }

  // ignore: missing_return
  static Widget availableWidgetDependOnStep(
      {@required DeliverSteps steps,
      @required BuildContext context,
      Function onDetailsPressed,
      Function acceptDelivery}) {
    switch (steps) {
      case DeliverSteps.SEARCHING:
        return Column(
          children: [],
        );
        break;
      case DeliverSteps.THERE_ARE_ORDER:
        return ThereAreOrderCard(
          onDetailsPressed: onDetailsPressed,
        );
        break;
      case DeliverSteps.ORDER_DETAIL:
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30..h)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 3.5.h),
              child: Column(
                children: [
                  OrderValidate(vehicle: "motor"),
                  SizedBox(height: 1.95.h),
                  Padding(
                    padding: ConstPadMargin.listViewPadding,
                    child: Row(
                      children: [
                        Expanded(
                          child: SimpleButton(
                              title: "Accepter", onTap: acceptDelivery),
                        ),
                        SizedBox(width: 2.5.w),
                        Expanded(
                          child: SimpleButton(
                            title: "Annuler",
                            onTap: () {},
                            whiteMode: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        break;
      case DeliverSteps.DELIVERING:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: Text(
              "Votre destination",
              style: Styles.ucolisGeneralBlackBoldFont
                  .copyWith(fontWeight: FontWeight.w800),
            )),
            SizedBox(height: 1.0.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                ExtendedContainer(
                  shape: BoxShape.circle,
                  color: blackFont,
                  child: MaterialInkWell(
                    customBorder: CircleBorder(),
                    onPressed: onDetailsPressed,
                    child: Padding(
                      padding: EdgeInsets.all(1.0.h),
                      child: Center(
                        child: Icon(
                          Icons.place,
                          color: Colors.white,
                          size: 1.85.h,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.5.w),
                Flexible(
                    child: Text.rich(TextSpan(
                        text: "No 64, Kings Cross Underground Station, KZF67T",
                        style: Styles.ucolisGeneralBlackBoldFont
                            .copyWith(fontSize: 14.0.sp),
                        children: [
                      TextSpan(
                          text: "\n" + "Ouagadougou",
                          style: TextStyle(color: greyFont, fontSize: 10.0.sp))
                    ])))
              ],
            ),
            Spacer(),
            SimpleButton(
              title: ConstString.cancel,
              onTap: () {
                Get.back();
              },
            )
          ],
        );
        break;

      case DeliverSteps.WAITING:
        final storage = new FlutterSecureStorage();

        void makeRiderOnline() {
          Geofire.initialize("availableDrivers");
          Geofire.setLocation(
              Provider.of<AppData>(context, listen: false).id,
              Provider.of<AppData>(context, listen: false)
                  .pickupAdress
                  .latitude,
              Provider.of<AppData>(context, listen: false)
                  .pickupAdress
                  .longitude);
          //driverref.onValue.listen((event) {});
        }
        void getLocationLiveUpdate() {
          StreamSubscription<Position> homestream;
          homestream =
              Geolocator.getPositionStream().listen((Position position) {
            Adress adress = new Adress();
            print(position.latitude);

            adress.latitude = position.latitude;
            adress.longitude = position.longitude;
            adress.placeName = Provider.of<AppData>(context, listen: false)
                .pickupAdress
                .placeName;
            adress.placeId = Provider.of<AppData>(context, listen: false)
                .pickupAdress
                .placeId;

            Provider.of<AppData>(context, listen: false)
                .updatePickupAdress(adress);
            if (Provider.of<AppData>(context, listen: false)
                    .riderOnlineState
                    .isOnline ==
                true) {
              
            }

            LatLng latLng = LatLng(position.latitude, position.longitude);
          });
        }
        void removeRider() {
          Geofire.removeLocation(
              Provider.of<AppData>(context, listen: false).id);
          //  driverref.onDisconnect();
          // driverref.remove();
          //driverref = null;
          Fluttertoast.showToast(
              msg: "Vous êtes hors ligne",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: Text(
              "Votre Position",
              style: Styles.ucolisGeneralBlackBoldFont
                  .copyWith(fontWeight: FontWeight.w800),
            )),
            SizedBox(height: 1.0.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                ExtendedContainer(
                  shape: BoxShape.circle,
                  color: blackFont,
                  child: MaterialInkWell(
                    customBorder: CircleBorder(),
                    onPressed: onDetailsPressed,
                    child: Padding(
                      padding: EdgeInsets.all(1.0.h),
                      child: Center(
                        child: Icon(
                          Icons.place,
                          color: Colors.white,
                          size: 1.85.h,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.5.w),
                Flexible(
                    child: Text.rich(TextSpan(
                        text: Provider.of<AppData>(context, listen: false)
                                    .pickupAdress ==
                                null
                            ? "Localisation En cours"
                            : Provider.of<AppData>(context)
                                .pickupAdress
                                .placeName,
                        style: Styles.ucolisGeneralBlackBoldFont
                            .copyWith(fontSize: 14.0.sp),
                        children: [
                      TextSpan(
                          text: "\n" + "Côte d'Ivoire",
                          style: TextStyle(color: greyFont, fontSize: 10.0.sp))
                    ])))
              ],
            ),
            Spacer(),
            SimpleButton(
              title: Provider.of<AppData>(context, listen: true)
                  .riderOnlineState
                  .text,
              color: Provider.of<AppData>(context, listen: true)
                  .riderOnlineState
                  .color,
              onTap: () {
                if (Provider.of<AppData>(context, listen: false)
                        .riderOnlineState
                        .isOnline ==
                    false) {
             

                  Fluttertoast.showToast(
                      msg: "Vous êtes en ligne",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  Provider.of<AppData>(context, listen: false)
                      .updateRiderOnlineState(true);
                  //makeRiderOnline();
                  getLocationLiveUpdate();
                } else {
                  removeRider();
                  Provider.of<AppData>(context, listen: false)
                      .updateRiderOnlineState(false);
                }

                //Get.back();
              },
            )
          ],
        );
        break;
    }
  }
}
