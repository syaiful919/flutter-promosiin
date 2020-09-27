import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/repository/post_repository.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/ui/components/molecules/dialog.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _memberRepository = locator<MemberRepository>();
  final _postRepository = locator<PostRepository>();

  BuildContext pageContext;
  List<PostModel> newPost;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
    getPosts();
  }

  Future<void> getPosts() async {
    try {
      List<PostModel> result = await _postRepository.getNewPosts();
      newPost = result;
    } catch (e) {
      print(">>> error: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getPostById() async {
    _postRepository.getPostById();
  }

  Future<void> updatePost() async {
    _postRepository.updatePost();
  }

  Future<void> deletePost() async {
    _postRepository.deletePost();
  }

  void goToInAppWebviewPage() => _navigationService.pushNamed(
      Routes.inAppWebviewPage,
      arguments: InAppWebviewPageArguments(redirectUrl: "https://google.com"));

  void goToWidgetExperimentPage() =>
      _navigationService.pushNamed(Routes.widgetExperimentPage);

  void showMessageDialog() async {
    var action = await Dialogs.okDialog(
      context: pageContext,
      title: "Sorry...",
      subtitle: "Something wrong with our server, please try again later.",
    );
    if (action == DialogAction.yes) {
      print(">>> yes clicked");
    } else {
      print(">>> else clicked");
    }
  }
}
