import 'dart:async';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/service/connectivity/connectivity_service.dart';
import 'package:base_project/service/connectivity/connectivity_status.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MyAccountViewModel extends StreamViewModel {
  final _navigationService = locator<NavigationService>();
  final _connectivityService = locator<ConnectivityService>();

  final _memberRepository = locator<MemberRepository>();

  final _mainVM = locator<MainViewModel>();

  BuildContext pageContext;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
  }

  void logOut() {
    _memberRepository.logOut();
    goToHome();
  }

  void goToHome() => _mainVM.setIndex(0);

  void goToNoInternetPage() =>
      _navigationService.pushToNoInternetPage(Routes.mainPage);

  @override
  Stream get stream => _connectivityService.status;

  @override
  void onData(data) {
    super.onData(data);
    if (data == ConnectivityStatus.Offline) goToNoInternetPage();
  }
}
