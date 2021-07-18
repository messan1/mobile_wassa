import 'package:flutter/material.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/styles/styles.dart';
import 'package:sizer/sizer.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key key, @required this.icon, @required this.onPressed, this.useLightMode, this.buttonColor, this.iconButtonColor, this.length,
  }) : super(key: key);
  final IconData icon;
  final Function onPressed;
  final bool useLightMode;
  final Color buttonColor;
  final Color iconButtonColor;
  final int length;
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        ExtendedContainer(
          alignment: Alignment.center,
          shape: BoxShape.circle,
          color:useLightMode == true? Colors.white: buttonColor == null? blackFont : buttonColor,
          boxShadow: [
            Styles.backButtonShadow
          ],
          child: MaterialInkWell(
            onPressed: onPressed,
            customBorder: CircleBorder(),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(2.85.h),
                child: Icon(icon, color: useLightMode== true? blackFont : iconButtonColor==null?  Colors.white : iconButtonColor,),
              ),
            ),
          ),
        ),
       length != null? Positioned(
          right: -.80.w ,
          top: -.50.h,
          child: ExtendedContainer(
            alignment: Alignment.center,
            color: useLightMode == true? blackFont : whiteFont,
            shape: BoxShape.circle,
            padding: EdgeInsets.all(.75.h),
            child: Center(
              child: Text(length!= null && length > 9 ? "+9" : length.toString(), textAlign: TextAlign.center, style: Styles.ucolisGeneralBlackBoldFont.copyWith(
                color: useLightMode == true?  whiteFont : blackFont ,fontSize: 7.5.sp
              ),),
            ),
          ),
        ) : Positioned(child: Container(), bottom: -10000,)
      ],
    );
  }
}
