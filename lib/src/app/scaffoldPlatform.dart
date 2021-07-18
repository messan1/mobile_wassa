import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ucolis/src/views/components/backArrowButton.dart';
import 'package:ucolis/src/views/styles/styles.dart';

class ScaffoldPlatform extends StatelessWidget {
  final Widget child;
  final String appBarTitle;
  final bool activeBackButton;
  final Widget leading;
  final Color titleColor;
  final Color backgroundColor;
  final Widget drawer;
  final Color appBarIconColor;
  final GlobalKey<ScaffoldState> scaffoldState;
  const ScaffoldPlatform(
      {Key key,
      this.appBarTitle,
      this.activeBackButton,
      @required this.child,
      this.leading,
      this.titleColor,
      this.drawer,
      this.scaffoldState,
      this.backgroundColor,
      this.appBarIconColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldState,
      backgroundColor: backgroundColor ?? whiteFont,
      extendBodyBehindAppBar: true,
      drawer: drawer,
      appBar: AppBar(
        leading: leading == null ? BackArrowButton() : leading,
        iconTheme: IconThemeData(
            color: appBarIconColor == null ? Colors.white : appBarIconColor),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          appBarTitle ?? "",
          style: titleColor == null
              ? headerStyle
              : headerStyle.copyWith(color: titleColor),
        ),
      ),
      body: child,
    );
  }
}
