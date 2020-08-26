import 'dart:async';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/service/connectivity/connectivity_service.dart';
import 'package:base_project/service/connectivity/connectivity_status.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StreamSampleViewModel extends StreamViewModel {
  final _navigationService = locator<NavigationService>();
  final _connectivityService = locator<ConnectivityService>();

  BuildContext pageContext;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
  }

  void goBack() => _navigationService.pop();

  void goToNoInternetPage() =>
      _navigationService.pushToNoInternetPage(Routes.streamSamplePage);

  @override
  Stream get stream => _connectivityService.status;

  @override
  void onData(data) {
    super.onData(data);
    if (data == ConnectivityStatus.Offline) goToNoInternetPage();
  }
}
