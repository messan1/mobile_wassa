import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/extendedContainer.dart';
import 'package:ucolis/src/views/components/materialInkWell.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class SendTipCard extends StatelessWidget {
  const SendTipCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxInt _selectedTip = 0.obs;

    return ExtendedContainer(
      child: Column(
        children: [
          Row(
            children: List.generate(4, (index) =>    _tipValueButton(index: index, selectedTip: _selectedTip, onPressed: (){
              _selectedTip.value = index;
            })
            ),
          ),
          SizedBox(height: 5.0.h,),
          Text(ConstString.tipAreWelcome, style: Styles.ucolisGeneralBlackBoldFont,),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleButton(title: ConstString.send, normalCase: true, onTap: (){

              },),
            ],
          ))
        ],
      ),
    );
  }

  Widget _tipValueButton({@required int index, @required RxInt selectedTip, @required Function onPressed}) {
    int _tipPercent = index > 2? (index*5)+5 : index * 5;
    return Expanded(
              child: Obx(()=> ExtendedContainer(
                color: selectedTip.value != index? whiteFont: blackFont ,
                margin: EdgeInsets.only(right: 1.5.w),
                boxShadow: [Styles.backButtonShadow],
                personalizeBorderRadius: BorderRadius.circular(2.35.h),
                child: MaterialInkWell(
                  radius: 2.35.h,
                  onPressed: onPressed,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.35.h),
                    child: Center(child: Text("$_tipPercent%", maxLines: 1, style: Styles.ucolisGeneralBlackBoldFont.copyWith(color: selectedTip.value != index? blackFont :whiteFont),)),
                  ),
                ),
              )),
            );
  }
}