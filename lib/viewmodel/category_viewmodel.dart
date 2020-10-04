import 'dart:async';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/category_model.dart';
import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/model/entity/promotion_model.dart';
import 'package:base_project/model/entity/user_model.dart';
import 'package:base_project/repository/post_repository.dart';
import 'package:base_project/service/connectivity/connectivity_service.dart';
import 'package:base_project/service/connectivity/connectivity_status.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CategoryViewModel extends StreamViewModel {
  final _navigationService = locator<NavigationService>();
  final _connectivityService = locator<ConnectivityService>();
  final _postRepository = locator<PostRepository>();

  BuildContext pageContext;

  List<PostModel> posts;
  CategoryModel category;
  PromotionModel promotion;

  Future<void> firstLoad({
    BuildContext context,
    CategoryModel cat,
    PromotionModel promo,
  }) async {
    if (pageContext == null && context != null) pageContext = context;

    if (cat != null) {
      category = cat;
      runBusyFuture(getPostByCategory());
    }

    if (promo != null) {
      promotion = promo;
      runBusyFuture(getPostByTag());
    }
  }

  Future<void> getPostByCategory() async {
    try {
      List<PostModel> result =
          await _postRepository.getPostByCategory(category.categoryId);
      posts = result;
      posts.forEach((element) {
        print(element.title);
      });
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<void> getPostByTag() async {
    try {
      List<PostModel> result =
          await _postRepository.getPostByTag(promotion.name);
      posts = result;
      posts.forEach((element) {
        print(element.title);
      });
    } catch (e) {
      print(">>> error: $e");
    }
  }

  void goToPostDetailPage(PostModel post) => _navigationService.pushNamed(
        Routes.postDetailPage,
        arguments: PostDetailPageArguments(post: post),
      );

  void goToUserPostPage(String id, UserModel user) =>
      _navigationService.pushNamed(
        Routes.userPostPage,
        arguments: UserPostPageArguments(userId: id, user: user),
      );

  void goBack() => _navigationService.pop();

  void goToNoInternetPage() => _navigationService.pushToNoInternetPage(
        Routes.categoryPage,
        arguments: CategoryPageArguments(
          category: category,
          promotion: promotion,
        ),
      );

  @override
  Stream get stream => _connectivityService.status;

  @override
  void onData(data) {
    super.onData(data);
    // if (data == ConnectivityStatus.Offline) goToNoInternetPage();
  }
}
