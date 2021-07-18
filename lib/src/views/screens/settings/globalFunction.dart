import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class GlobalFunction {
  static Future<File> imageGetter(BuildContext context) async {
    final _picker = ImagePicker();
    File _image;
    PickedFile _pickedFile;

    _pickedFile = (await _picker.getImage(source: ImageSource.gallery));
    _image = File(_pickedFile.path);
    return _image;
  }
}
