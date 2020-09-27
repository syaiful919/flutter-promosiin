import 'dart:convert';

String registerRequestModelToJson(RegisterRequestModel data) =>
    json.encode(data.toJson());

class RegisterRequestModel {
  RegisterRequestModel({
    this.email,
    this.username,
    this.password,
  });

  String email;
  String username;
  String password;

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "username": password == null ? null : password,
      };
}
