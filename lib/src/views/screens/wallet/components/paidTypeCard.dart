import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/constants/constString.dart';
import 'package:ucolis/src/views/screens/wallet/components/paidType.dart';

class PaidTypeCard extends StatelessWidget {
  const PaidTypeCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PaidType(
            image: "assets/icon/moneyBag.svg",
            paidType: Langue.paidCash[
                Provider.of<VoiceData>(context, listen: false).langue],
            sum: "30.000",
          ),
        ),
        Expanded(
          child: PaidType(
            image: "assets/icon/bank.svg",
            paidType: Langue.paidCompte[
                Provider.of<VoiceData>(context, listen: false).langue],
            sum: "12.500",
          ),
        ),
      ],
    );
  }
}
