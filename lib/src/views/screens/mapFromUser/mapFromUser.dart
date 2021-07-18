import 'dart:async';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/appData.dart';
import 'package:ucolis/src/Model/AuthState.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/enum.dart';
import 'package:ucolis/src/views/components/closeButtonU.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/mapFromUser/components/inSearchView.dart';
import 'package:ucolis/src/views/screens/mapFromUser/components/popUpDeliverPosition.dart';
import 'package:ucolis/src/views/screens/mapFromUser/controller/mapWidgetController.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class MapFromUser extends StatefulWidget {
//A faire revenir en Stateless

  @override
  _MapFromUserState createState() => _MapFromUserState();
}

class _MapFromUserState extends State<MapFromUser> {
  RxBool _searching = true.obs;
  Rx<DeliverySteps> _steps = DeliverySteps.GOING.obs;
  //DatabaseReference rideRequest;

  void saveRideRequest() {
   // rideRequest = FirebaseDatabase.instance.reference().child("Ride Request");
    var initailpos = Provider.of<AppData>(context, listen: false).pickupAdress;
    var dropoff = Provider.of<AppData>(context, listen: false).dropOffadress;

    Map pickUp = {
      "lattitue": initailpos.latitude.toString(),
      "longitude": initailpos.longitude.toString(),
    };

    Map dropoffLocation = {
      "lattitue": dropoff.latitude.toString(),
      "longitude": dropoff.longitude.toString(),
    };

    Map user = {
      "name": Provider.of<AuthState>(context, listen: false).username,
      "phone": Provider.of<AuthState>(context, listen: false).email
    };

    Map rideInfor = {
      "driver_id": "Waiting",
      "Payment": "cash",
      "pickUp": pickUp,
      "dropOff": dropoffLocation,
      "created_at": DateTime.now().toString(),
      "user": user
    };

    //rideRequest.push().set(rideInfor);
  }

  void removeRide() {
   // rideRequest.remove();
  }

  @override
  void initState() {
    saveRideRequest();

    //startTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startTimer() async {
    await Future.delayed(Duration(seconds: 10)).then((value) async {
      _searching.toggle();
      await Future.delayed(Duration(seconds: 5)).then((value) async {
        _steps.value = DeliverySteps.ARRIVED;
        await Future.delayed(Duration(seconds: 5)).then((value) async {
          Get.toNamed("/successDelivery")?.then((value) async {
            _steps.value = DeliverySteps.HALFWAY;
            await Future.delayed(Duration(seconds: 5)).then((value) async {
              _steps.value = DeliverySteps.TIP;
              await Future.delayed(Duration(seconds: 5)).then((value) async {
                _steps.value = DeliverySteps.NOTICE;
                await Future.delayed(Duration(seconds: 5)).then((value) {
                  _steps.value = DeliverySteps.GOING;
                });
              });
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final String _vehicle = Get.arguments;

    return Obx(() => ScaffoldPlatform(
          activeBackButton: true,
          leading: _searching.value == true
              ? Row(
                  children: [
                    SizedBox(
                      width: 1.385.w,
                    ),
                    Expanded(
                      child: CloseButtonU(
                        onTap: () {
                         // rideRequest.remove();

                          Get.back();

                          print(_searching.value);
                        },
                      ),
                    ),
                  ],
                )
              : null,
          // _searching.value == true? false:
          appBarTitle: _searching.value == true
              ? ""
              : MapWidgetController.thisAppBarTitleDependOnStep(
                  steps: _steps.value),
          child: Stack(overflow: Overflow.visible, children: [
            Positioned.fill(
              child: Image.asset(
                "assets/map.jpg",
                fit: BoxFit.cover,
              ),
            ),
            _searching.value == true
                ? InSearchView(
                    vehicle: _vehicle,
                  )
                : Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: _searching.value == true
                              ? 0
                              : MapWidgetController
                                  .thisBottomSheetHeightDependOnStep(
                                      steps: _steps.value),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: whiteFont,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30..h)),
                          ),
                          child: Padding(
                            padding: ConstPadMargin.listViewPadding,
                            child: Column(
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
                                      color: Colors.blueGrey.withOpacity(.35),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.0.h,
                                ),
                                MapWidgetController
                                    .thisVehicleTypeAndNumbIsVisible(
                                        steps: _steps.value),
                                Expanded(
                                    child: MapWidgetController
                                        .thisStepAvailableCard(
                                            steps: _steps.value)),
                                SizedBox(
                                  height: 3.0.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -7.5.h,
                          left: 0,
                          child: _profileBox(),
                        )
                      ],
                    ),
                  ),
            _searching.value == true
                ? Positioned(
                    child: Container(),
                    bottom: -10000,
                  )
                : _steps.value == DeliverySteps.ARRIVED
                    ? PopUpDeliverPosition()
                    : Positioned(
                        child: Container(),
                        bottom: -100000,
                      )
          ]),
        ));
  }

  Widget _profileBox() {
    return ExtendedContainer(
      height: 16.75.h,
      width: 16.75.h,
      color: Colors.white,
      shape: BoxShape.circle,
      padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 2.5.h),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          ExtendedContainer(
            personalizeBorderRadius: BorderRadius.circular(2.0.h),
            image: DecorationImage(
                image: AssetImage("assets/images/photoUser.png"),
                fit: BoxFit.fill),
          ),
          Positioned(
            child: Text(
              "Yanne",
              textAlign: TextAlign.center,
              style: nameDetailStyle,
            ),
            bottom: -3.5.h,
            left: 0,
            right: 0,
          )
        ],
      ),
    );
  }
}
