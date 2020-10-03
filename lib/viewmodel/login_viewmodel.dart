import 'dart:convert';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/user_model.dart';
import 'package:base_project/model/request/login_request_model.dart';
import 'package:base_project/model/response/auth_response_model.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/utils/custom_exception.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _memberRepository = locator<MemberRepository>();

  BuildContext pageContext;

  String username = "";
  String password = "";

  bool tryingToLogin = false;
  String errorMessage;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
  }

  void changeUsername(String val) {
    username = val;
    removeErrorMessage();
  }

  void changePassword(String val) {
    password = val;
    removeErrorMessage();
  }

  void removeErrorMessage() {
    if (errorMessage != null) errorMessage = null;
    notifyListeners();
  }

  Future<void> loginAction() async {
    try {
      tryingToLogin = true;
      notifyListeners();

      AuthResponseModel response =
          await _memberRepository.login(LoginRequestModel(
        email: username.toLowerCase().trim(),
        password: password,
      ));

      print(">>> id: ${response.userId}");

      _memberRepository.saveUserId(response.userId);
      UserModel result =
          await _memberRepository.getUserDataRemote(response.userId);
      _memberRepository.saveUserData(result);

      _memberRepository.setIsLogin(true);
      _navigationService.pushNamedAndRemoveUntil(Routes.mainPage);
    } on UnauthorizedException {
      errorMessage = "Incorrect email or password";
    } catch (e) {
      print(">>> error $e");
      errorMessage = "Something error, please try again later";
    } finally {
      tryingToLogin = false;
      notifyListeners();
    }
  }

  void goToRegisterPage() =>
      _navigationService.pushReplacementNamed(Routes.registerPage);

  void goBack() => _navigationService.pop();
}
