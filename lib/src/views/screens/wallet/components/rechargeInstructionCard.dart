import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class RechargeInstructionCard extends StatelessWidget {
  const RechargeInstructionCard({
    Key key,
    @required String sum, this.instructions,
  }) : _sum = sum, super(key: key);

  final String _sum;
  final List<String> instructions;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Montant", style: Styles.ucolisGeneralBlackBoldFont,),
            Spacer(),
            Text.rich(TextSpan(text: _sum, style: Styles.ucolisGeneralBlackBoldFont.copyWith(color: blueFont,), children: [
              TextSpan(text: " "+"FCFA", style: Styles.ucolisGeneralBlackBoldFont)
            ]))
          ],
        ),
        Divider(),
        SizedBox(height: 1.35.h),
        for(var instruction in instructions)  _instructionBuilder(context, instruction),
      ],
    );
  }

  Widget _instructionBuilder(BuildContext context, String instruction) {
    return Padding(
        padding: EdgeInsets.only(bottom: 1.45.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            Icon(Icons.arrow_forward_outlined, size: 1.65.h,),
            Flexible(child: Text.rich(HTML.toTextSpan(context, instruction, defaultTextStyle: componentMenuStyle.copyWith(fontSize: 11.5.sp)), style: componentMenuStyle.copyWith(fontSize: 11.5.sp)),)
          ],
        ),
      );
  }
}
// HTML.toTextSpan(context, instruction)
// Text(, style: componentMenuStyle.copyWith(fontSize: 11.5.sp)