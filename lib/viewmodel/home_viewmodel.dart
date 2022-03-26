import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/category_model.dart';
import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/model/entity/promotion_model.dart';
import 'package:base_project/model/entity/user_model.dart';
import 'package:base_project/repository/category_repository.dart';
import 'package:base_project/repository/post_repository.dart';
import 'package:base_project/repository/promotion_repository.dart';
import 'package:base_project/service/connectivity/connectivity_service.dart';
import 'package:base_project/service/connectivity/connectivity_status.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/ui/components/molecules/dialog.dart';
import 'package:base_project/utils/stream_key.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:base_project/extension/extended_string.dart';

class HomeViewModel extends MultipleStreamViewModel {
  final _navigationService = locator<NavigationService>();
  final _connectivityService = locator<ConnectivityService>();

  final _memberRepository = locator<MemberRepository>();
  final _postRepository = locator<PostRepository>();
  final _categoryRepository = locator<CategoryRepository>();
  final _promotionRepository = locator<PromotionRepository>();

  BuildContext pageContext;
  List<PostModel> newPost;
  List<CategoryModel> categories;
  List<PromotionModel> promotions;

  bool isNetworkError = false;

  UserModel get user => dataMap[StreamKey.dataChanged];

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
    runBusyFuture(getNewPosts());
    runBusyFuture(getCategories());
    runBusyFuture(getPromotions());
    // getUserData();
    isNetworkError = false;
  }

  Future<void> getUserData() async {
    UserModel user = _memberRepository.getUserData();
    _memberRepository.setDataStream(user);

    notifyListeners();
  }

  Future<void> getNewPosts() async {
    try {
      List<PostModel> result = await _postRepository.getNewPosts();
      newPost = result;
      // if (newPost != null && newPost.length > 0) {
      //   for (int i = 0; i < newPost.length; i++) {
      //     UserModel result =
      //         await _memberRepository.getUserDataRemote(newPost[i].userId);
      //     newPost[i].user = result;
      //   }
      // }
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

  void goToUserPostPage(String id, UserModel user) =>
      _navigationService.pushNamed(
        Routes.userPostPage,
        arguments: UserPostPageArguments(userId: id, user: user),
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

  void goToNoInternetPage() async {
    _navigationService.pushToNoInternetPage(Routes.mainPage);
  }

  @override
  Map<String, StreamData> get streamsMap => {
        StreamKey.authStatus: StreamData<bool>(_memberRepository.isLogin),
        StreamKey.dataChanged:
            StreamData<UserModel>(_memberRepository.isDataChanged),
        StreamKey.postAdded: StreamData<bool>(_postRepository.isPostAdded),
        StreamKey.connectivity:
            StreamData<ConnectivityStatus>(_connectivityService.status),
      };

  @override
  void onData(String key, data) {
    super.onData(key, data);
    if (key == StreamKey.connectivity) {
      if (data == ConnectivityStatus.Offline) isNetworkError = true;
    } else if (key == StreamKey.authStatus) {
      if (data && user == null) {
        getUserData();
      }
    } else if (key == StreamKey.postAdded) {
      if (data) {
        _postRepository.setPostAdded(false);
        getNewPosts();
      }
    }
  }
}
