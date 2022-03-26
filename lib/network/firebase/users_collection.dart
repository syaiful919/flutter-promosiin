import 'package:base_project/model/entity/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UsersCollection {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<UserModel> getUserById({@required String id}) async {
    try {
      var result = await usersCollection.doc(id).get();
      return UserModel.fromJson(result.data());
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<void> createUser({
    @required String id,
    @required UserModel user,
  }) async {
    try {
      usersCollection.doc(id).set(user.toJson());
    } catch (e) {
      print(">>> error: $e");
    }
  }
}
