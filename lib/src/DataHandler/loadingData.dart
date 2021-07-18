import 'package:flutter/cupertino.dart';
import 'package:progress_state_button/progress_button.dart';

class LoadingData extends ChangeNotifier {
    ButtonState stateOnlyText = ButtonState.idle;


  void updateloadingState(ButtonState data) {
    stateOnlyText = data;
    notifyListeners();
  }
}
