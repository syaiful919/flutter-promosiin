import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/category_model.dart';
import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/model/entity/promotion_model.dart';
import 'package:base_project/repository/category_repository.dart';
import 'package:base_project/repository/post_repository.dart';
import 'package:base_project/repository/promotion_repository.dart';
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
  final _categoryRepository = locator<CategoryRepository>();
  final _promotionRepository = locator<PromotionRepository>();

  BuildContext pageContext;
  List<PostModel> newPost;
  List<CategoryModel> categories;
  List<PromotionModel> promotions;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
    runBusyFuture(getNewPosts());
    runBusyFuture(getCategories());
    runBusyFuture(getPromotions());
  }

  Future<void> getNewPosts() async {
    try {
      List<PostModel> result = await _postRepository.getNewPosts();
      newPost = result;
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<void> getCategories() async {
    try {
      List<CategoryModel> result = await _categoryRepository.getCategories();
      categories = result;
    } catch (e) {
      print(">>> error: $e");
    }
  }

  Future<void> getPromotions() async {
    try {
      List<PromotionModel> result = await _promotionRepository.getPromotions();
      promotions = result;
      promotions.forEach((element) {
        print(">>> ${element.name}");
      });
    } catch (e) {
      print(">>> error: $e");
    }
  }

  void goToCategoryPage({CategoryModel cat, PromotionModel promo}) =>
      _navigationService.pushNamed(
        Routes.categoryPage,
        arguments: CategoryPageArguments(
          category: cat,
          promotion: promo,
        ),
      );

  void goToPostDetailPage(PostModel post) => _navigationService.pushNamed(
        Routes.postDetailPage,
        arguments: PostDetailPageArguments(post: post),
      );

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
