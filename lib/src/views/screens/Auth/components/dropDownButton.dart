import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ucolis/src/views/styles/styles.dart';

import 'extendedContainer.dart';

class DropButton extends StatelessWidget {
  final List<String> items;
  final String value, title;
  final Function(String) onChanged;

  const DropButton({
    Key key,
    @required this.items,
    this.value,
    this.onChanged,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            title,
            style: inputStyle,
          ),
        ),
        SizedBox(height: 7),
        ExtendedContainer(
          personalizeBorderRadius: BorderRadius.circular(15),
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: greyFont.withOpacity(.45),
          child: DropdownButton(
            items: buildMItem(items),
            underline: Container(width: double.infinity),
            isExpanded: true,
            value: value,
            elevation: 0,
            dropdownColor: whiteFont.withOpacity(.7),
            icon: Align(
              child: Icon(Icons.keyboard_arrow_down_rounded, color: blackFont),
              alignment: Alignment.centerRight,
            ),
            iconSize: 18,
            hint: Text(
              '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ),
            onChanged: (value) => onChanged(value),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> buildMItem(List<String> items) {
    return items
        .map((item) => DropdownMenuItem<String>(
              child: Row(
                children: [
                  Text(
                    item,
                    textScaleFactor: .85,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: blackFont,
                    ),
                  ),
                ],
              ),
              value: item,
            ))
        .toList();
  }
}
