import 'package:base_project/model/entity/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesCollection {
  CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  Future<List<CategoryModel>> getCategories() async {
    try {
      var result = await categoriesCollection.orderBy("name").get();
      List<CategoryModel> categories = [];
      result.docs.forEach((element) {
        categories.add(CategoryModel.fromJson(element.data()));
      });

      return categories;
    } catch (e) {
      print(">>> error: $e");
    }
  }
}
