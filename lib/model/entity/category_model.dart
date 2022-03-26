import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.categoryId,
    this.name,
  });

  String categoryId;
  String name;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryId: json["category_id"] == null ? null : json["category_id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId == null ? null : categoryId,
        "name": name == null ? null : name,
      };
}
