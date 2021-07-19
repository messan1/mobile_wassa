import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/route_manager.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/loadingData.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/scaffoldPlatform.dart';
import 'package:ucolis/src/blocs/userBloc.dart';
import 'package:ucolis/src/constants/constAudio.dart';
import 'package:ucolis/src/constants/constLangue.dart';
import 'package:ucolis/src/services/db.dart';
import 'package:ucolis/src/views/components/simpleButtonLoading.dart';
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
  DbService _internaldb = new DbService();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    setupPlaylist();
    if (Provider.of<VoiceData>(context, listen: false).activercommandeVocal)
      playAudio();
    super.initState();
  }

  void setupPlaylist() async {
    List<Audio> arr = [];
    for (String i in data[3]
        [Provider.of<VoiceData>(context, listen: false).langue]) {
      arr.add(Audio('assets/' + i));
    }
    audioPlayer.open(Playlist(audios: arr),
        showNotification: false, autoStart: true);
  }

  playAudio() async {
    await audioPlayer.play();
    audioPlayer.playlistFinished.listen((finished) {
      if (finished) {
        print("fini");
        //Navigator.of(context).pop();
      }
    });
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
                  StreamBuilder<List<File>>(
                    stream: userBloc.documents,
                    initialData: <File>[],
                    builder: (context, snapshot) {
                      return SimpleButtonLoading(
                        title: Langue.save[
                            Provider.of<VoiceData>(context, listen: false)
                                .langue],
                        onTap: () {
                          _internaldb.uploadFiles(snapshot.data, context);
                        },
                        state: null,
                      );
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
