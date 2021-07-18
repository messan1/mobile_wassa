import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/views/screens/Auth/components/extendedContainer.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/styles/styles.dart';


class Docs extends StatelessWidget {
  const Docs({
    Key key,
    @required this.doc,
    @required this.index,
    @required this.userBloc,
  }) : super(key: key);
  final File doc;
  final int index;
  final UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<File>>(
        stream: userBloc.documents,
        builder: (context, snapshot) {
          return Stack(
            overflow: Overflow.visible,
            children: [
              ExtendedContainer(
                height: .1,
                useBorderRadius: true,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeCalculator.width(context, width: .0165)),
                width: SizeCalculator.width(context, width: .3),
                color: Colors.blueGrey,
                image: DecorationImage(
                    image: ExtendedFileImageProvider(doc), fit: BoxFit.cover),
              ),
              Positioned(
                child: ExtendedContainer(
                  height: .035,
                  width: SizeCalculator.height(context, height: .035),
                  shape: BoxShape.circle,
                  color: whiteFont.withOpacity(.5),
                  child: Material(
                    shape: StadiumBorder(),
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(SizeCalculator.height(context)),
                      onTap: () {
                        userBloc.deleteDoc(index: index);
                      },
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: blackFont,
                          size: SizeCalculator.height(context, height: .025),
                        ),
                      ),
                    ),
                  ),
                ),
                top: SizeCalculator.height(context, height: .007),
                right: SizeCalculator.width(context, width: .025),
              )
            ],
          );
        });
  }
}
