import 'dart:io';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/service/image_picker/image_picker_service.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetExperimentViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _imagePicker = locator<ImagePickerService>();

  BuildContext pageContext;

  File image;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
  }

  void goBack() => _navigationService.pop();

  void openCamera() async {
    image = await _imagePicker.getImageFromCamera();
    notifyListeners();
  }

  void openGallery() async {
    image = await _imagePicker.getImageFromGallery();
    notifyListeners();
  }
}
