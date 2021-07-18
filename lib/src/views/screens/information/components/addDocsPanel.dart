import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/views/screens/Auth/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/Auth/components/verticalSeparator.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/screens/styles/styles.dart';

class AddDocsPanel extends StatelessWidget {
  const AddDocsPanel({
    Key key,
    @required this.userBloc,
  }) : super(key: key);
  final UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      height: .375,
      color: Colors.blueGrey,
      personalizeBorderRadius: BorderRadius.circular(
        SizeCalculator.height(context, height: .035),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(
          SizeCalculator.height(context, height: .035),
        ),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(
            SizeCalculator.height(context, height: .035),
          ),
          onTap: () {
            userBloc.documentsGetter(context);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Langue.importer[
                    Provider.of<VoiceData>(context, listen: false).langue],
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: TextStyle(color: whiteFont, fontWeight: FontWeight.w900),
              ),
              VerticalSeparator(),
              ExtendedContainer(
                height: .075,
                useBorderRadius: true,
                width: SizeCalculator.width(context, width: .25),
                color: blueFont,
                boxShadow: [Styles.backButtonShadow()],
                child: Center(
                  child: Icon(
                    Icons.add_circle_outline,
                    color: whiteFont,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
