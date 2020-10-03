import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/network/firebase/posts_collection.dart';

class PostRepository {
  final PostsCollection _collection = PostsCollection();

  Future<void> createPost(PostModel post) => _collection.createPost(post);

  Future<List<PostModel>> getNewPosts() => _collection.getPosts();

  Future<List<PostModel>> getPostByCategory(String categoryId) =>
      _collection.getPostsByField(
        key: "category.category_id",
        value: categoryId,
      );

  Future<List<PostModel>> getPostByTag(String tagId) =>
      _collection.getPostsThatContains(
        key: "tags",
        value: tagId,
      );

  Future<List<PostModel>> getPostByUserId(String userId) =>
      _collection.getPostsByField(
        key: "user_id",
        value: userId,
      );

  Future<void> getPostById() => _collection.getPost();

  Future<void> updatePost() => _collection.updatePost();

  Future<void> deletePost() => _collection.deletePost();
}
