import 'dart:async';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/service/url_launcher/url_launcher_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PostDetailViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _urlLauncherService = locator<UrlLauncherService>();
  final _memberRepository = locator<MemberRepository>();

  BuildContext pageContext;

  String userId;

  PostModel post;
  bool showLink = false;
  bool showEditButton = false;

  Future<void> firstLoad({BuildContext context, PostModel post}) async {
    if (pageContext == null && context != null) pageContext = context;
    this.post = post;
    if (this.post.externalLink != null && this.post.externalLink.length > 0)
      showLink = true;
    getUserId();
    checkPostOwner();
    notifyListeners();
  }

  void getUserId() {
    userId = _memberRepository.getUserId();
  }

  void checkPostOwner() {
    if (userId != null && userId == post.userId) showEditButton = true;
  }

  void goBack() => _navigationService.pop();

  void goToCreatePostPage() => _navigationService.pushNamed(
        Routes.createPostPage,
        arguments: CreatePostPageArguments(post: post),
      );

  void launchUrl(String url) => _urlLauncherService.launchUrl(url);
}
