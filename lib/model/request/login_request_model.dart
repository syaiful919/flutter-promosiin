import 'dart:convert';

String loginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

class LoginRequestModel {
  LoginRequestModel({
    this.email,
    this.password,
  });

  String email;
  String password;

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "password": password == null ? null : password,
      };
}
