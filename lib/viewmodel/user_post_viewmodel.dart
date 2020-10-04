import 'dart:async';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/model/entity/user_model.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/repository/post_repository.dart';
import 'package:base_project/service/connectivity/connectivity_service.dart';
import 'package:base_project/service/connectivity/connectivity_status.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:base_project/extension/extended_string.dart';

class UserPostViewModel extends StreamViewModel {
  final _navigationService = locator<NavigationService>();
  final _connectivityService = locator<ConnectivityService>();
  final _postRepository = locator<PostRepository>();
  final _memberRepository = locator<MemberRepository>();

  BuildContext pageContext;

  List<PostModel> posts;
  String userId;
  UserModel user;

  String currentUserId;
  String appBarTitle = "";

  bool isNetworkError = false;

  Future<void> firstLoad({
    @required BuildContext context,
    @required String id,
    UserModel usr,
  }) async {
    if (pageContext == null && context != null) pageContext = context;
    if (userId == null && id != null) userId = id;
    if (user == null && usr != null) user = usr;
    runBusyFuture(getUserId());
    runBusyFuture(getUserPost());
    isNetworkError = false;
  }

  Future<void> getUserId() async {
    currentUserId = _memberRepository.getUserId();
    if (currentUserId == userId) {
      appBarTitle = "My Post";
    } else {
      appBarTitle = user?.username == null
          ? "My Post"
          : "Postingan ${user.username.capitalize()}";
    }
  }

  Future<void> getUserPost() async {
    try {
      List<PostModel> result = await _postRepository.getPostByUserId(userId);
      posts = result;
    } catch (e) {
      print(">>> error: $e");
    }
  }

  void goToPostDetailPage(PostModel post) => _navigationService.pushNamed(
        Routes.postDetailPage,
        arguments: PostDetailPageArguments(post: post),
      );

  void goBack() => _navigationService.pop();

  void goToNoInternetPage() => _navigationService.pushToNoInternetPage(
        Routes.userPostPage,
        arguments: UserPostPageArguments(userId: userId, user: user),
      );

  @override
  Stream get stream => _connectivityService.status;

  @override
  void onData(data) {
    super.onData(data);
    if (data == ConnectivityStatus.Offline) isNetworkError = true;
  }
}
