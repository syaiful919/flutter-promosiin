import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.email,
    this.username,
    this.profilePicture,
  });

  String email;
  String username;
  String profilePicture;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"] == null ? null : json["email"],
        username: json["username"] == null ? null : json["username"],
        profilePicture:
            json["profile_picture"] == null ? null : json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "username": username == null ? null : username,
        "profile_picture": profilePicture == null ? null : profilePicture,
      };
}
