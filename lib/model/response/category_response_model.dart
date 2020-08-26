import 'package:base_project/model/entity/category.dart';

class CategoryResponseModel {
  List<Category> category;
  bool error;

  CategoryResponseModel({this.category, this.error});

  CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      category = List<Category>();
      json['result'].forEach((v) {
        category.add(Category.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.category != null) {
      data['result'] = this.category.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}
