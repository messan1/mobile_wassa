import 'package:flutter/material.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/constants/enum.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/screens/mapFromUser/components/noticeCard.dart';
import 'package:ucolis/src/views/screens/mapFromUser/components/phoneMessageAndCancelCard.dart';
import 'package:ucolis/src/views/screens/mapFromUser/components/postNoticeAndTipCard.dart';
import 'package:ucolis/src/views/screens/mapFromUser/components/sendTipCard.dart';
import 'package:ucolis/src/views/screens/mapFromUser/components/vehicleTypeAndNumber.dart';

abstract class MapWidgetController{
  // ignore: missing_return
  static Widget thisStepAvailableCard({@required DeliverySteps steps}){
    switch(steps){
      case DeliverySteps.GOING:
        return PhoneMessageAndCancelCard();
        break;
      case DeliverySteps.ARRIVED:
        return PhoneMessageAndCancelCard();
        break;
      case DeliverySteps.HALFWAY:
        return PostNoticeAndTipCard();
        break;
      case DeliverySteps.TIP:
        return SendTipCard();
        break;
      case DeliverySteps.NOTICE:
        return NoticeCard();
        break;
    }
  }
  // ignore: missing_return
  static Widget thisVehicleTypeAndNumbIsVisible({@required DeliverySteps steps}){
    switch(steps){

      case DeliverySteps.GOING:
        return VehicleTypeAndNumber(number: "HS785K", vehicle: "Volkswagen jetta");
    break;
      case DeliverySteps.ARRIVED:
        return VehicleTypeAndNumber(number: "HS785K", vehicle: "Volkswagen jetta");
        break;
      case DeliverySteps.HALFWAY:
        return VehicleTypeAndNumber(number: "HS785K", vehicle: "Volkswagen jetta");

        break;
      case DeliverySteps.TIP:
        return SizedBox(height: 13.0.h,);
        break;
      case DeliverySteps.NOTICE:
        return SizedBox(height: 5.0.h,);
        break;
    }
  }
  // ignore: missing_return
  static String thisAppBarTitleDependOnStep({@required DeliverySteps steps}){
    switch(steps){
      case DeliverySteps.GOING:
        return ConstString.going;
        break;
      case DeliverySteps.ARRIVED:
        return ConstString.arrived;
        break;
      case DeliverySteps.HALFWAY:
        return ConstString.halfWay;
        break;
      case DeliverySteps.TIP:
        return ConstString.tip;
        break;
      case DeliverySteps.NOTICE:
        return ConstString.postNotice;
        break;
    }
  }
  // ignore: missing_return
  static double thisBottomSheetHeightDependOnStep({@required DeliverySteps steps}){
    switch(steps){
      case DeliverySteps.GOING:
        return 30.5.h;
        break;
      case DeliverySteps.ARRIVED:
        return 30.5.h;
        break;
      case DeliverySteps.HALFWAY:
        return 30.5.h;
        break;
      case DeliverySteps.TIP:
        return 55.5.h;

        break;
      case DeliverySteps.NOTICE:
        return 65.5.h;
        break;
      default:
        return 30.5.h;
        break;
    }
  }
}


