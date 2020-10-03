import 'package:base_project/model/entity/promotion_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionsCollection {
  CollectionReference promotionsCollection =
      FirebaseFirestore.instance.collection('tags');

  Future<List<PromotionModel>> getPromotions() async {
    try {
      var result = await promotionsCollection.get();
      List<PromotionModel> promotions = [];
      result.docs.forEach((element) {
        promotions.add(PromotionModel.fromJson(element.data()));
      });

      return promotions;
    } catch (e) {
      print(">>> error: $e");
    }
  }
}
