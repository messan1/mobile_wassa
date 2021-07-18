import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/utils/sizeCalculator.dart';
import 'package:ucolis/src/views/screens/dashboard/components/dashBoardSlide.dart';
import 'package:sizer/sizer.dart';

class DashSlider extends StatelessWidget {
  const DashSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: SC.height(),
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 2.0,
                initialPage: 0,
              ),
              items: [
                DashBoardSlide(
                  text: Langue.salut[
                          Provider.of<VoiceData>(context, listen: false)
                              .langue] +
                      " " +
                      "Yanne" +
                      ", " +
                      Langue.welcomeOnDash[
                          Provider.of<VoiceData>(context, listen: false)
                              .langue],
                  image: Positioned(top: 60..h, right: -0, child: Container()),
                ),
                DashBoardSlide(
                  text: Langue.shippingTextOnDash[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  image: Positioned(
                    left: 0,
                    child: Container(),
                  ),
                ),
                DashBoardSlide(
                  text: Langue.shippingTextOnDash2[
                      Provider.of<VoiceData>(context, listen: false).langue],
                  image: Positioned(
                    top: -10,
                    right: 0,
                    child: Container(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
