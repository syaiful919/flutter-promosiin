import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    this.result,
    this.error,
  });

  LoginResult result;
  bool error;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        result: json["result"] == null
            ? null
            : LoginResult.fromJson(json["result"]),
        error: json["error"] == null ? null : json["error"],
      );
}

class LoginResult {
  LoginResult({
    this.token,
  });

  String token;

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
        token: json["token"] == null ? null : json["token"],
      );
}
