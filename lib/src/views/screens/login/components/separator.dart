import 'package:flutter/material.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/styles/styles.dart';


class Separator extends StatelessWidget {
  const Separator({
    Key key,
    @required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeCalculator.height(context, height: .025),
          horizontal: SizeCalculator.width(context, width: .015)),
      child: Row(
        children: [
          Flexible(
            child: Divider(
              color: greyFont,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title ?? '',
              style: separatorStyle,
            ),
          ),
          Flexible(
            child: Divider(
              color: greyFont,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
