import 'dart:async';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/user_model.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/service/connectivity/connectivity_service.dart';
import 'package:base_project/service/connectivity/connectivity_status.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/ui/components/molecules/dialog.dart';
import 'package:base_project/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MyAccountViewModel extends StreamViewModel {
  final _navigationService = locator<NavigationService>();
  final _connectivityService = locator<ConnectivityService>();

  final _memberRepository = locator<MemberRepository>();

  final _mainVM = locator<MainViewModel>();

  BuildContext pageContext;

  UserModel user;
  String userId;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
    // getUserData();
  }

  Future<void> getUserData() async {
    user = _memberRepository.getUserData();
    userId = _memberRepository.getUserId();
    notifyListeners();
  }

  void showLogoutDialog(BuildContext context) async {
    var action = await Dialogs.yesNoDialog(
      context: context,
      title: "Yakin akan keluar ?",
    );
    if (action == DialogAction.yes) logOut();
  }

  void logOut() {
    _memberRepository.logOut();
    goToHome();
  }

  void goToHome() => _mainVM.setIndex(0);

  void goToUserPostPage() => _navigationService.pushNamed(Routes.userPostPage,
      arguments: UserPostPageArguments(userId: userId));

  void goToNoInternetPage() =>
      _navigationService.pushToNoInternetPage(Routes.mainPage);

  @override
  Stream get stream => _memberRepository.isLogin;

  @override
  void onData(data) {
    super.onData(data);
    if (data && user == null) {
      getUserData();
    } else if (!data && user != null) {
      user = null;
      notifyListeners();
    }
  }
}
