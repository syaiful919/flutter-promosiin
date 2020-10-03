import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PostsCollection {
  CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future<void> createPost(PostModel post) async {
    try {
      postsCollection.doc(post.postId).set(post.toJson());
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<void> updatePost() async {
    try {
      await postsCollection.doc("ughG8MqrWWORvKbCEoIu").update(PostModel(
            title: "title edit",
            description: "desc",
          ).toJson());
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<List<PostModel>> getPosts({
    int limit = 20,
  }) async {
    try {
      var result = await postsCollection
          .orderBy("date_created", descending: true)
          .limit(limit)
          .get();
      List<PostModel> posts = [];
      result.docs.forEach((element) {
        posts.add(PostModel.fromJson(element.data()));
      });

      return posts;
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<void> getMorePosts({
    int limit = 20,
    @required QueryDocumentSnapshot lastDoc,
  }) async {
    try {
      var result =
          await postsCollection.startAfterDocument(lastDoc).limit(limit).get();
      print(result.docs[0].data());
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<List<PostModel>> getPostsByField({
    @required String key,
    @required dynamic value,
    int limit = 20,
  }) async {
    try {
      var result =
          await postsCollection.where(key, isEqualTo: value).limit(limit).get();
      List<PostModel> posts = [];
      result.docs.forEach((element) {
        posts.add(PostModel.fromJson(element.data()));
      });

      return posts;
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<List<PostModel>> getPostsThatContains({
    @required String key,
    @required dynamic value,
    int limit = 20,
  }) async {
    try {
      var result = await postsCollection
          .where(key, arrayContains: value)
          .limit(limit)
          .get();
      List<PostModel> posts = [];
      result.docs.forEach((element) {
        posts.add(PostModel.fromJson(element.data()));
      });

      return posts;
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<void> getMorePostsByField({
    @required String key,
    @required dynamic value,
    int limit = 20,
    @required QueryDocumentSnapshot lastDoc,
  }) async {
    try {
      var result = await postsCollection
          .where(key, isEqualTo: value)
          .startAfterDocument(lastDoc)
          .limit(limit)
          .get();
      print(result.docs[0].data());
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<void> search({String key, dynamic value}) async {
    try {
      var result =
          await postsCollection.where(key, arrayContainsAny: value).get();
      print(result.docs[0].data());
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<void> getPost() async {
    try {
      var result = await postsCollection.doc("ughG8MqrWWORvKbCEoIu").get();
      print(result.data());
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<void> deletePost() async {
    try {
      await postsCollection.doc("ughG8MqrWWORvKbCEoIu").delete();
    } catch (e) {
      print(">>> error: $e");
    }
  }
}
