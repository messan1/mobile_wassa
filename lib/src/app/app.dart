import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/appData.dart';
import 'package:ucolis/src/DataHandler/loadingData.dart';
import 'package:ucolis/src/DataHandler/userAuth.dart';
import 'package:ucolis/src/DataHandler/voiceData.dart';
import 'package:ucolis/src/app/platformApp.dart';
import 'package:sizer/sizer.dart';
import 'package:ucolis/src/blocs/userBloc.dart';

final _userBloc = UserBloc();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          child: PlatformApp(),
          providers: [
            ChangeNotifierProvider(
              create: (context) => AppData(),
            ),
            ChangeNotifierProvider(
              create: (context) => LoadingData(),
            ),
            ChangeNotifierProvider(
              create: (context) => UserAuth(),
            ),
            ChangeNotifierProvider(
              create: (context) => VoiceData(),
            ),
            Provider(create: (context) => _userBloc),
          ],
        );
      },
    );
  }
}
