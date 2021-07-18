import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/simpleButton.dart';

class PostNoticeAndTipCard extends StatelessWidget {
  const PostNoticeAndTipCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(child: SimpleButton(title: ConstString.notice, onTap: (){}, normalCase: true,),),
            SizedBox(width: 3.5.w),
            Expanded(child: SimpleButton(title: ConstString.tips, onTap: (){}, normalCase: true, whiteMode: true,),),

          ],
        ),
      ],
    );
  }
}
