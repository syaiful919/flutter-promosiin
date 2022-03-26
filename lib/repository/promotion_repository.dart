import 'package:base_project/model/entity/promotion_model.dart';
import 'package:base_project/network/firebase/promotions_collection.dart';

class PromotionRepository {
  final PromotionsCollection _collection = PromotionsCollection();

  Future<List<PromotionModel>> getPromotions() => _collection.getPromotions();
}
