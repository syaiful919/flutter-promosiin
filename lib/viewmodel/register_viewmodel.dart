import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/user_model.dart';
import 'package:base_project/model/request/register_request_model.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/utils/custom_exception.dart';
import 'package:base_project/utils/regex.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _memberRepository = locator<MemberRepository>();

  BuildContext pageContext;

  String username = "";
  String password = "";
  String email = "";

  bool tryingToRegister = false;
  String errorMessage;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
  }

  void changeUsername(String val) {
    username = val;
    removeErrorMessage();
  }

  void changePassword(String val) {
    removeErrorMessage();
    password = val;
  }

  void changeEmail(String val) {
    removeErrorMessage();
    email = val;
  }

  void removeErrorMessage() {
    if (errorMessage != null) errorMessage = null;
    notifyListeners();
  }

  bool isEmailValid() => emailRegExp.hasMatch(email);

  void registerValidation() {
    if (!isEmailValid()) {
      errorMessage = "Email tidak valid";
      notifyListeners();
    } else {
      registerAction();
    }
  }

  Future<void> registerAction() async {
    try {
      tryingToRegister = true;
      notifyListeners();
      var response = await _memberRepository.register(RegisterRequestModel(
        email: email.toLowerCase().trim(),
        password: password,
        username: username.toLowerCase().trim(),
      ));

      _memberRepository.saveUserId(response.userId);
      UserModel result =
          await _memberRepository.getUserDataRemote(response.userId);
      _memberRepository.saveUserData(result);
      _memberRepository.setIsLogin(true);
      _navigationService.pushNamedAndRemoveUntil(Routes.mainPage);
    } on BadRequestException catch (e) {
      errorMessage = e.message;
    } catch (e) {
      errorMessage = "Something error, please try again later";
    } finally {
      tryingToRegister = false;
      notifyListeners();
    }
  }

  void goToLoginPage() =>
      _navigationService.pushReplacementNamed(Routes.loginPage);

  void goBack() => _navigationService.pop();
}
