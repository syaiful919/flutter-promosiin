import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UsersCollection {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> getUserById({@required String id}) async {
    try {
      var result = await usersCollection.doc(id).get();
      print(result.data());
    } catch (e) {
      print(">>> error: $e");
    }
  }
}
