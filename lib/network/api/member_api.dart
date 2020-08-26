import 'dart:convert';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/request/login_request_model.dart';
import 'package:base_project/model/response/login_response_model.dart';
import 'package:base_project/network/http_client_helper.dart';
import 'package:flutter/foundation.dart';

class MemberApi {
  final _helper = locator<HttpClientHelper>();

  Future<LoginResponseModel> guestLogin() async {
    final response = await _helper.post(url: "member/guest_login");
    return LoginResponseModel.fromJson(response);
  }

  Future<LoginResponseModel> login(LoginRequest loginRequest) async {
    final response = await _helper.post(
        url: "member/login", body: json.encode(loginRequest.toJson()));
    return LoginResponseModel.fromJson(response);
  }
}
