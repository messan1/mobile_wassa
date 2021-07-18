import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/components/platformTextFieldForm.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxInt _note = 0.obs;
    return Stack(
      children: [
        ExtendedContainer(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) => _noticeStar(index: index, note: _note, onPressed: (){
                      _note.value = index;
                    })),
                  ),
                  SizedBox(height: 1.0.h,),
                  Obx(()=>               Text(ConstString.noticeInLetter(note: _note.value), maxLines: 1, textAlign: TextAlign.center, style: Styles.ucolisGeneralBlackBoldFont.copyWith(fontSize: 15.0.sp, fontWeight: FontWeight.w800),),
                  )
                ],
              ),
              SizedBox(height: 1.5.h),
              Expanded(
                child: PlatformTextFieldForm.textAreaPlatform(hintText: "Message",),
              ),

            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ExtendedContainer(
            alignment: Alignment.bottomCenter,
            color: whiteFont,
            height: 12.0.h,
            child: SimpleButton(
              title: ConstString.sendTips,
              normalCase: true,
              onTap: () {},
            ),
          ),
        )

      ],
    );
  }

  Widget _noticeStar({@required int index, @required RxInt note, @required Function onPressed}) {
    return Obx(()=> ExtendedContainer(
      shape: BoxShape.circle,
      child: MaterialInkWell(
        customBorder: CircleBorder(),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 3.5.h),
          child: Icon( note.value >= index? Icons.star_rounded : Icons.star_outline_rounded, color: note.value >= index? blackFont : greyFont,size: 4.85.h,),
        ),
      ),
    ));
  }
}
