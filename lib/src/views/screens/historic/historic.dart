import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constPadMargin.dart';
import 'package:ucolis/src/constants/constSize.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/components/buttonWithArrow.dart';
import 'package:ucolis/src/views/screens/historic/components/orderCardWithStatus.dart';

class Historic extends StatefulWidget {
  @override
  _HistoricState createState() => _HistoricState();
}

class _HistoricState extends State<Historic>
    with SingleTickerProviderStateMixin {
  bool showHistoric = false;
  AnimationController controller;

  @override
  initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPlatform(
        appBarIconColor: Colors.black,
        activeBackButton: true,
        appBarTitle:
            Langue.histo[Provider.of<VoiceData>(context, listen: false).langue],
        child: SafeArea(
          child: ListView(
            padding: ConstPadMargin.listViewPadding,
            children: [
              SizedBox(height: ConstSize.safeAreaListView),
              ButtonWithArrow(
                arrowDirection: Icons.keyboard_arrow_down_rounded,
                onPressed: () {
                  setState(() {
                    showHistoric = !showHistoric;
                    showHistoric ? controller.forward() : controller.reverse();
                  });
                },
                title: Langue.colis[
                    Provider.of<VoiceData>(context, listen: false).langue],
                controller: controller,
              ),
              SizedBox(
                height: 2.5.h,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.linear,
                height: showHistoric
                    ? MediaQuery.of(context).size.height * 0.608
                    : 0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      OrderCardWithStatus(
                        date: "8 June 2019, 18:39",
                        status: true,
                        beginTime: "11:24",
                        endTime: "11:24",
                        startingPoint: "Ouagadougou, Burkina Faso aeroport",
                        deliveryPoint: "Cité air France",
                      ),
                      OrderCardWithStatus(
                        date: "8 June 2019, 18:39",
                        status: false,
                        beginTime: "11:24",
                        endTime: "11:24",
                        startingPoint: "Ouagadougou, Burkina Faso aeroport",
                        deliveryPoint: "Cité air France",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              ButtonWithArrow(
                arrowDirection: Icons.keyboard_arrow_down_rounded,
                onPressed: () {},
                title: Langue.transport[
                    Provider.of<VoiceData>(context, listen: false).langue],
                controller: controller,
              ),
            ],
          ),
        ));
  }
}
