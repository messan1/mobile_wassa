import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/views/screens/dashboard/components/orderResume.dart';
import 'package:ucolis/src/views/screens/dashboard/components/orderTracker.dart';

class OrderValidate extends StatelessWidget {
  const OrderValidate({
    Key key,
    @required String vehicle,
  }) : _vehicle = vehicle, super(key: key);

  final String _vehicle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ConstPadMargin.listViewPadding,
      child: Column(
        children: [
          OrderResume(vehicle: _vehicle),
          SizedBox(height: 2.85.h,),
          OrderTracker(),
        ],
      ),
    );
  }
}
