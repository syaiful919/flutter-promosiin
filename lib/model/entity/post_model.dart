import 'dart:convert';

import 'package:base_project/model/entity/category_model.dart';
import 'package:base_project/model/entity/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.postId,
    this.title,
    this.description,
    this.category,
    this.imagePath,
    this.externalLink,
    this.userId,
    this.dateCreated,
    this.isRecommended,
    this.tags,
    this.user,
    this.location,
  });

  String postId;
  String title;
  String description;
  CategoryModel category;
  String imagePath;
  List<ExternalLink> externalLink;
  String userId;
  DateTime dateCreated;
  bool isRecommended;
  List<String> tags;
  UserModel user;
  String location;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        postId: json["post_id"] == null ? null : json["post_id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        category: json["category"] == null
            ? null
            : CategoryModel.fromJson(json["category"]),
        imagePath: json["image_path"] == null ? null : json["image_path"],
        externalLink: json["external_link"] == null
            ? null
            : List<ExternalLink>.from(
                json["external_link"].map((x) => ExternalLink.fromJson(x))),
        userId: json["user_id"] == null ? null : json["user_id"],
        dateCreated: json["date_created"] == null
            ? null
            : (json["date_created"] as Timestamp).toDate(),
        isRecommended:
            json["is_recommended"] == null ? null : json["is_recommended"],
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        location: json["location"] == null ? null : json["location"],
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId == null ? null : postId,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "category": category == null ? null : category.toJson(),
        "image_path": imagePath == null ? null : imagePath,
        "external_link": externalLink == null
            ? null
            : List<dynamic>.from(externalLink.map((x) => x.toJson())),
        "user_id": userId == null ? null : userId,
        "date_created":
            dateCreated == null ? null : Timestamp.fromDate(dateCreated),
        "is_recommended": isRecommended == null ? null : isRecommended,
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "user": user == null ? null : user.toJson(),
        "location": location == null ? null : location,
      };
}

class ExternalLink {
  ExternalLink({
    this.title,
    this.url,
  });

  String title;
  String url;

  factory ExternalLink.fromJson(Map<String, dynamic> json) => ExternalLink(
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "url": url == null ? null : url,
      };
}
