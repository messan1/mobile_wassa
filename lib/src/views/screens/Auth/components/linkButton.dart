import 'package:flutter/material.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({
    Key key,
    @required this.title,
    @required this.onTap,
    this.boldLink = true,
  }) : super(key: key);
  final String title;
  final Function onTap;
  final bool boldLink;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: linkStyle.copyWith(
              fontWeight:
                  boldLink == true ? FontWeight.w900 : FontWeight.normal),
        ),
      ),
    );
  }
}
