import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ucolis/src/services/auth.dart';

import 'connectWithSocialNetwork.dart';

class NetworkGroup extends StatelessWidget {
  const NetworkGroup({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService auth = new AuthService();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ConnectWithSocialNetwork(
          fontAwesomeIcons: FontAwesomeIcons.facebook,
          onTap: () {
            auth.facebookSignIn();
          },
        ),
        ConnectWithSocialNetwork(
          fontAwesomeIcons: FontAwesomeIcons.twitter,
          onTap: () {},
        ),
        ConnectWithSocialNetwork(
          fontAwesomeIcons: FontAwesomeIcons.google,
          onTap: () async {
            // await AuthService.googleSignIn();
            auth.googleSignIn();
          },
        ),
      ],
    );
  }
}
