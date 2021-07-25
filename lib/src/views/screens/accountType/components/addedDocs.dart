import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/views/screens/Auth/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/screens/styles/styles.dart';

import 'docs.dart';

class AddedDocs extends StatelessWidget {
  const AddedDocs({
    Key key,
    @required this.userBloc,
  }) : super(key: key);
  final UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<File>>(
        stream: userBloc.documents,
        initialData: <File>[],
        builder: (context, snapshot) {
          return ExtendedContainer(
            height: .165,
            useBorderRadius: true,
            boxShadow: [Styles.backButtonShadow()],
            child: snapshot.data.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeCalculator.height(context, height: .03)),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index) {
                      var doc = snapshot.data[index];
                      return Docs(doc: doc, index: index, userBloc: userBloc);
                    },
                  )
                : Center(
                    child: Text(
                      Langue.nodoc[
                          Provider.of<VoiceData>(context, listen: false)
                              .langue],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: greyFont, fontWeight: FontWeight.bold),
                    ),
                  ),
          );
        });
  }
}
