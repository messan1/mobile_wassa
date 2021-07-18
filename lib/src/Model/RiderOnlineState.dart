import 'package:flutter/material.dart';

class RiderOnlineState {
  String text = "Voute êtes en hors ligne";
  Color color = Colors.black;
  bool isOnline = false;

  RiderOnlineState(
      {this.color = Colors.black,
      this.isOnline = false,
      this.text = "Voute êtes en hors ligne"});
}
