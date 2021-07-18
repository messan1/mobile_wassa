import 'package:flutter/material.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class StartEnd extends StatelessWidget {
  const StartEnd({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: blueFont, shape: BoxShape.circle),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 45,
              width: 1.0,
              decoration: BoxDecoration(color: Colors.black),
            ),
          ),
          Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }
}
