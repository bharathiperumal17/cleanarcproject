import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final xFilegallery =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // final xFilecamera =
    //     await ImagePicker().pickImage(source: ImageSource.camera);

    if (xFilegallery != null) {
      return File(xFilegallery.path);
    } /* else if (xFilecamera != null) {
      return File(xFilecamera.path);
    } */
    return null;
  } catch (e) {
    return null;
  }
}
