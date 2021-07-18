import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Lottie.asset('assets/error.json'),
          Center(child: Text("Impossible d'avancer"),),
        ],
      ),
    );
  }
}
