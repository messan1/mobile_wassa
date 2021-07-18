import 'package:get/route_manager.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/constants/constAudio.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/views/components/voiceCommand.dart';
import 'package:ucolis/src/views/screens/Auth/components/simpleButton.dart';
import 'package:ucolis/src/views/screens/Auth/components/verticalSeparator.dart';
import 'package:ucolis/src/views/screens/information/components/addDocsPanel.dart';
import 'package:ucolis/src/views/screens/information/components/addedDocs.dart';

import 'package:ucolis/src/views/screens/login/login.dart';
import 'package:ucolis/src/views/screens/settings/sizeCalculator.dart';
import 'package:ucolis/src/views/screens/styles/styles.dart';

class AddDocument extends StatefulWidget {
  @override
  _AddDocumentState createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      if (Provider.of<VoiceData>(context, listen: false).activercommandeVocal) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return VoiceDialogBox(
                  audio: data[3]
                      [Provider.of<VoiceData>(context, listen: false).langue],
                  close: true);
            }).then((value) {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    final _userBloc = UserBloc();
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String email = "";
    String firstname = "";
    String lastname = "";
    String number = "";
    String bith = "";
    String password = "";

    final _size = MediaQuery.of(context).size;
    final _orientation = MediaQuery.of(context).orientation;
    final _userBloc = Provider.of<UserBloc>(context);
    @override
    void initState() {
      final _userBloc = Provider.of<UserBloc>(context, listen: false);
      _userBloc.firstName.listen((event) {
        firstname = event;
      });
      _userBloc.lastName.listen((event) {
        lastname = event;
      });
      _userBloc.email.listen((event) {
        email = event;
      });
      _userBloc.bithday.listen((event) {
        bith = event;
      });
      _userBloc.phone.listen((event) {
        number = event;
      });
      _userBloc.password.listen((event) {
        password = event;
      });
      super.initState();
    }

    final UserBloc userBloc = _userBloc;
    return LoaderOverlay(
      useDefaultLoading: true,
      child: ScaffoldPlatform(
        appBarTitle:
            Langue.ins4[Provider.of<VoiceData>(context, listen: false).langue],
        activeBackButton: false,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: SizeCalculator.width(context, width: .085)),
            children: [
              Text(
                Langue.etape[
                        Provider.of<VoiceData>(context, listen: false).langue] +
                    " 4/4",
                textAlign: TextAlign.center,
                style: headerStyle,
              ),
              SizedBox(
                height: _orientation == Orientation.portrait
                    ? _size.height * .12
                    : _size.width * .08,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddDocsPanel(userBloc: _userBloc),
                  VerticalSeparator(),
                  Container(
                    child: AddedDocs(userBloc: _userBloc),
                  ),
                ],
              ),
              VerticalSeparator(
                height: .08,
              ),
              Column(
                children: [
                  StreamBuilder<String>(
                    builder: (context, snapshot) {
                      return SimpleButton(
                          title: Langue.save[
                              Provider.of<VoiceData>(context, listen: false)
                                  .langue],
                          onTap: () {
                            if (Provider.of<VoiceData>(context, listen: false)
                                .activercommandeVocal) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return VoiceDialogBox(
                                        audio: data[4][Provider.of<VoiceData>(
                                                context,
                                                listen: false)
                                            .langue],
                                        close: true);
                                  }).then((value) {
                                Get.offAll(Login());
                              });
                            } else
                              Get.offAll(Login());
                          });
                    },
                  ),
                  VerticalSeparator(height: .014),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
