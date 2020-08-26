import 'package:base_project/locator/locator.dart';
import 'package:base_project/service/connectivity/connectivity_service.dart';
import 'package:base_project/service/connectivity/connectivity_status.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NoInternetViewModel extends StreamViewModel {
  final _navigationService = locator<NavigationService>();
  final _connectivityService = locator<ConnectivityService>();

  BuildContext pageContext;

  String routeName;
  var argument;

  Future<void> firstLoad({
    BuildContext context,
    String routeName,
    argument,
  }) async {
    if (pageContext == null && context != null) pageContext = context;
    this.routeName = routeName;
    if (argument != null) this.argument = argument;
  }

  void goBack() {
    if (data == ConnectivityStatus.Offline) {
      print(">>> Please check your internet connection");
    } else {
      _navigationService.pushReplacementNamed(
        this.routeName,
        arguments: this.argument,
      );
    }
  }

  @override
  Stream get stream => _connectivityService.status;
}
