import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final _picker = ImagePicker();

  Future<File> getImageFromGallery() async {
    try {
      PickedFile pickedFile =
          await _picker.getImage(source: ImageSource.gallery);
      return (pickedFile == null) ? null : File(pickedFile.path);
    } catch (e) {
      debugPrint(">>> image picker error: $e");
      return null;
    }
  }

  Future<File> getImageFromCamera() async {
    try {
      PickedFile pickedFile = await _picker.getImage(
        source: ImageSource.camera,
        maxHeight: 500,
      );
      return (pickedFile == null) ? null : File(pickedFile.path);
    } catch (e) {
      debugPrint(">>> image picker error: $e");
      return null;
    }
  }
}
