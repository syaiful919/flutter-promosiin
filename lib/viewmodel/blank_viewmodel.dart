import 'package:base_project/locator/locator.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BlankViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  BuildContext pageContext;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
  }

  void goBack() => _navigationService.pop();
}
