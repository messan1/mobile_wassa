import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';
class DashBoardSlide extends StatelessWidget {
  const DashBoardSlide({
    Key key, @required this.image, @required this.text,
  }) : super(key: key);
  final Widget image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        image??Container(),
        ExtendedContainer(
          height: 70..h,
          personalizeBorderRadius: BorderRadius.circular(15..h),
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: SC.width(.02), vertical: SC.height(.015)),
          padding: EdgeInsets.all(5..h),
          useBorderRadius: true,
          boxShadow: [Styles.littleShadow],
          child: Center(child: Text(text??"", textAlign: TextAlign.center, style: messageHomeStyle.copyWith(fontWeight: FontWeight.bold, shadows: [
            Styles.littleShadow
          ]),)),
        ),
      ],
    );
  }
}
