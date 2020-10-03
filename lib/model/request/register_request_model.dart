import 'dart:convert';

String registerRequestModelToJson(RegisterRequestModel data) =>
    json.encode(data.toJson());

class RegisterRequestModel {
  RegisterRequestModel({
    this.email,
    this.username,
    this.password,
    this.profilePicture = "",
  });

  String email;
  String username;
  String password;
  String profilePicture;

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "username": username == null ? null : username,
        "profile_picture": profilePicture == null ? null : profilePicture,
      };
}
