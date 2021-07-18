import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------------
// ------------ COLOR STYLES
// ---------------------------------------------------------------------------------
final blueFont = Color(0xff1152FD);
final blackFont = Color(0xff3E4958);
final whiteFont = Colors.white;
final violetFont = Color(0xff3E2AD1);
final greyFont = Color(0xffD5DDE0);
final greenFont = Color(0xff52F338);
final redFont = Color(0xffEB5757);

// ---------------------------------------------------------------------------------
// ------------ TEXT STYLES
// ---------------------------------------------------------------------------------
//USED IN MANY INTERFAE FOR TEXT LIKE (Historique, Profil,...)
final firstStyle = TextStyle(color: blackFont, fontWeight: FontWeight.normal, fontSize: 15.0);
final sndStyle = TextStyle(color: blackFont, fontWeight: FontWeight.normal, fontSize: 13.0);
final buttonStyle = TextStyle(color: whiteFont, fontWeight: FontWeight.bold, fontSize: 18.0);
final linkStyle = TextStyle(
    color: blueFont,
    fontWeight: FontWeight.normal,
    fontSize: 15.0,
    decoration: TextDecoration.underline,
    decorationColor: blueFont);
final inputStyle = TextStyle(color: blackFont, fontWeight: FontWeight.bold, fontSize: 13.0);

//BASICS INTERFACE
final kTitleStyle = TextStyle(
  color: whiteFont,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);
final kSubtitleStyle = TextStyle(
  color: whiteFont,
  fontSize: 18.0,
  height: 1.2,
);
final headerStyle = TextStyle(color: blackFont, fontWeight: FontWeight.bold, fontSize: 20.0);
final separatorStyle = TextStyle(color: blackFont, fontWeight: FontWeight.normal, fontSize: 10.0);

//CLIENT HOME INTERFACE
final headerHomeStyle = TextStyle(color: whiteFont, fontWeight: FontWeight.bold, fontSize: 20.0);
final messageHomeStyle = TextStyle(color: blackFont, fontWeight: FontWeight.normal, fontSize: 20.0);
final prixMessageStyle = TextStyle(color: blackFont, fontWeight: FontWeight.normal, fontSize: 13.0);
final moneyStyle = TextStyle(color: blueFont, fontWeight: FontWeight.bold, fontSize: 14.0);
final menuHomeStyle = TextStyle(color: blackFont, fontWeight: FontWeight.bold, fontSize: 15.0);

//MENU INTERFACE
final nameMenuStyle = TextStyle(color: whiteFont, fontWeight: FontWeight.normal, fontSize: 20.0);
final mailMenuStyle = TextStyle(color: whiteFont, fontWeight: FontWeight.normal, fontSize: 15.0);
final componentMenuStyle = TextStyle(color: blackFont, fontWeight: FontWeight.normal, fontSize: 13.0);

//HISTORIQUE INTERFACE
final dateHistoStyle = TextStyle(color: whiteFont, fontWeight: FontWeight.bold, fontSize: 20.0);
final endStatusStyle = TextStyle(color: greenFont, fontWeight: FontWeight.normal, fontSize: 13.0);
final cancelStatusStyle = TextStyle(color: redFont, fontWeight: FontWeight.bold, fontSize: 13.0);
final nameDetailStyle = TextStyle(color: blackFont, fontWeight: FontWeight.bold, fontSize: 18.0);
final prixDetailStyle = TextStyle(color: blackFont, fontWeight: FontWeight.bold, fontSize: 26.0);

//CODE PROMO INTERFACE
final codePromoStyle = TextStyle(color: blueFont, fontWeight: FontWeight.bold, fontSize: 32.0);

//Shadow
abstract class Styles {
  static BoxShadow backButtonShadow() {
    return BoxShadow(
      offset: Offset(0, 3),
      color: Colors.blueGrey.shade900.withOpacity(0.35),
      blurRadius: 10,
      spreadRadius: -5,
    );
  }

  static BoxShadow littleShadow() {
    return BoxShadow(
      offset: Offset(0, 6),
      blurRadius: 6,
      spreadRadius: -2,
      color: Colors.blueGrey.shade900.withOpacity(0.20),
    );
  }
}
