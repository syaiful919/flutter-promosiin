import 'package:base_project/model/entity/category_model.dart';
import 'package:base_project/network/firebase/categories_collection.dart';

class CategoryRepository {
  final CategoriesCollection _collection = CategoriesCollection();

  Future<List<CategoryModel>> getCategories() => _collection.getCategories();
}
