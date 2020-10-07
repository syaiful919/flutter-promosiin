import 'dart:async';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/user_model.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/ui/components/molecules/dialog.dart';
import 'package:base_project/utils/stream_key.dart';
import 'package:base_project/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MyAccountViewModel extends MultipleStreamViewModel {
  final _navigationService = locator<NavigationService>();

  final _memberRepository = locator<MemberRepository>();

  final _mainVM = locator<MainViewModel>();

  BuildContext pageContext;

  // UserModel user;
  UserModel get user => dataMap[StreamKey.dataChanged];

  String userId;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
    getUserData();
  }

  Future<void> getUserData() async {
    UserModel user = _memberRepository.getUserData();
    _memberRepository.setDataStream(user);
    userId = _memberRepository.getUserId();
    print(">>> userId from stream $userId");
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

  void goToUserPostPage() {
    print(userId);
    _navigationService.pushNamed(Routes.userPostPage,
        arguments: UserPostPageArguments(userId: userId, user: user));
  }

  void goToEditProfilePage() => _navigationService.pushNamed(
        Routes.editProfilePage,
        arguments: EditProfilePageArguments(user: user, userId: userId),
      );

  void goToNoInternetPage() =>
      _navigationService.pushToNoInternetPage(Routes.mainPage);

  @override
  Map<String, StreamData> get streamsMap => {
        StreamKey.authStatus: StreamData<bool>(_memberRepository.isLogin),
        StreamKey.dataChanged:
            StreamData<UserModel>(_memberRepository.isDataChanged),
      };

  @override
  void onData(String key, data) {
    super.onData(key, data);
    if (key == StreamKey.authStatus) {
      if (data && (user == null || userId == null)) {
        getUserData();
      } else if (!data && (user != null || userId != null)) {
        userId = null;
        _memberRepository.setDataStream(null);
      }
    }
  }
}
