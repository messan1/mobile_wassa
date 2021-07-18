import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/support/components/supportUtils.dart';

class FaqCard extends StatelessWidget {
  const FaqCard({
    Key key, this.title, this.questions,
  }) : super(key: key);
  final String title;
  final List<String> questions;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      margin: EdgeInsets.only(bottom: 5.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(title, textScaleFactor:1.15, style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 3.5.h),
          for(var element in questions)   SupportUtils(title: element, onPressed: (){}),

        ],
      ),
    );
  }
}
