
import 'package:get/get.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:flutter/material.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/enum.dart';
import 'package:ucolis/src/views/components/Map.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/menuButton.dart';
import 'package:ucolis/src/views/screens/dashboard/components/ucolisDrawer.dart';
import 'package:ucolis/src/views/screens/mapFromDeliver/components/myLocationButton.dart';
import 'package:ucolis/src/views/screens/mapFromDeliver/controller/widgetControllerDeliverMap.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';


GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class MapFromDeliver extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    Rx<DeliverSteps> _steps = DeliverSteps.WAITING.obs;
    return Obx(() => ScaffoldPlatform(
          drawer: UcolisDrawer(),
          leading: _steps.value == DeliverSteps.THERE_ARE_ORDER
              ? null
              : MenuButton(
                  onPressed: () => _drawerKey.currentState.openDrawer(),
                ),
          appBarTitle:
              _steps.value == DeliverSteps.ORDER_DETAIL ? "Options" : "",
          child: Stack(
            children: [
              Positioned.fill(
                child: MapComponents(leading: 0, tilf: 0),
              ),
              Positioned(
                  bottom: WidgetControllerDeliverMap
                      .myLocationButtonPositionDependOnStep(
                          steps: _steps.value),
                  right: 3.5.w,
                  child: MyLocationButton(
                    onPressed: () {
                      _drawerKey.currentState.openDrawer();
                      // _steps.value = DeliverSteps.WAITING;
                    },
                  )),
              _steps.value == DeliverSteps.THERE_ARE_ORDER
                  ? Positioned.fill(
                      child: ExtendedContainer(
                      color: blackFont.withOpacity(.85),
                    ))
                  : Container(),
              Positioned(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height:
                      WidgetControllerDeliverMap.bottomSheetHeightDependOnStep(
                          steps: _steps.value),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteFont,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30..h)),
                  ),
                  child: SingleChildScrollView(
                    child: ExtendedContainer(
                      height: WidgetControllerDeliverMap
                          .bottomSheetHeightDependOnStep(steps: _steps.value),
                      padding: _steps.value == DeliverSteps.ORDER_DETAIL
                          ? EdgeInsets.zero
                          : ConstPadMargin.listViewPaddingVH,
                      child: WidgetControllerDeliverMap
                          .availableWidgetDependOnStep(
                              context: context,
                              steps: _steps.value,
                              onDetailsPressed: () {
                                _steps.value = DeliverSteps.ORDER_DETAIL;
                              },
                              acceptDelivery: () {
                                _steps.value = DeliverSteps.DELIVERING;
                              }),
                    ),
                  ),
                ),
                bottom: 0,
                left: 0,
                right: 0,
              ),
            ],
          ),
        ));
  }
}
