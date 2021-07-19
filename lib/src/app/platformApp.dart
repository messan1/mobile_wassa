import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ucolis/src/app/appRoutes.dart';

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        //SizerUtil().init(constraints, orientation);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ],
          builder: EasyLoading.init(),
          getPages: AppRoutes.routes,
          initialRoute: '/',
          defaultTransition: Transition.cupertino,
        );
      });
    });
  }
}
