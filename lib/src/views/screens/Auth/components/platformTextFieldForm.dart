import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ucolis/src/views/styles/styles.dart';

abstract class PlatformTextFieldForm {
  static textFieldPlatform(
      {@required String title,
      bool isPassword,
      double verticalContentPadding,
      Widget suffix,
      TextEditingController controller,
      bool enabled}) {
    BorderRadius borderRadius = BorderRadius.circular(15);

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
        TextFormField(
          controller: controller,
          obscureText: isPassword ?? false,
          enabled: enabled ?? true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  right: 5,
                  left: 10,
                  bottom: verticalContentPadding ?? 0,
                  top: verticalContentPadding ?? 0),
              fillColor: greyFont.withOpacity(.45),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(width: .95, color: greyFont)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(width: .95, color: greyFont)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(width: .95, color: greyFont)),
              errorBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(width: .95, color: greyFont)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(width: .95, color: greyFont)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(width: .95, color: greyFont)),
              suffixIcon: isPassword == true
                  ? Icon(
                      Icons.visibility_off_rounded,
                      color: blackFont.withOpacity(.35),
                    )
                  : suffix == null
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : suffix),
        ),
      ],
    );
  }
}
