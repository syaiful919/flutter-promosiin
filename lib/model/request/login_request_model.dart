import 'dart:convert';

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  LoginRequest({
    this.email,
    this.password,
    this.fcmToken = false,
    this.fromRegister = false,
    this.uuid = "",
  });

  String email;
  String password;
  dynamic fcmToken;
  bool fromRegister;
  String uuid;

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "fcm_token": fcmToken,
        "from_register": fromRegister == null ? null : fromRegister,
        "uuid": uuid == null ? null : uuid,
      };
}
