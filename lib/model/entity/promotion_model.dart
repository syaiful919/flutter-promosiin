// To parse this JSON data, do
//
//     final tagModel = tagModelFromJson(jsonString);

import 'dart:convert';

PromotionModel tagModelFromJson(String str) =>
    PromotionModel.fromJson(json.decode(str));

String tagModelToJson(PromotionModel data) => json.encode(data.toJson());

class PromotionModel {
  PromotionModel({
    this.tagId,
    this.name,
    this.bannerPath,
  });

  String tagId;
  String name;
  String bannerPath;

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
        tagId: json["tag_id"] == null ? null : json["tag_id"],
        name: json["name"] == null ? null : json["name"],
        bannerPath: json["banner_path"] == null ? null : json["banner_path"],
      );

  Map<String, dynamic> toJson() => {
        "tag_id": tagId == null ? null : tagId,
        "name": name == null ? null : name,
        "banner_path": bannerPath == null ? null : bannerPath,
      };
}
