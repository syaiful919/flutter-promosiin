import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/network/firebase/post_collection.dart';

class PostRepository {
  final PostCollection _collection = PostCollection();

  Future<void> createPost(PostModel post) => _collection.createPost(post);

  Future<List<PostModel>> getNewPosts() => _collection.getPosts();

  Future<void> getPostById() => _collection.getPost();

  Future<void> updatePost() => _collection.updatePost();

  Future<void> deletePost() => _collection.deletePost();
}
