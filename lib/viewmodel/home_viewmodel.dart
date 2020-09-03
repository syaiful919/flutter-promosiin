import 'package:base_project/locator/locator.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/repository/product_repository.dart';
import 'package:base_project/ui/components/molecules/dialog.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _memberRepository = locator<MemberRepository>();
  final _productRepository = locator<ProductRepository>();

  BuildContext pageContext;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
  }

  void goToStreamSamplePage() =>
      _navigationService.pushNamed(Routes.streamSamplePage);

  void goToMultipleStreamSamplePage() =>
      _navigationService.pushNamed(Routes.multipleStreamSamplePage);

  void goToInAppWebviewPage() => _navigationService.pushNamed(
      Routes.inAppWebviewPage,
      arguments: InAppWebviewPageArguments(redirectUrl: "https://google.com"));

  void showMessageDialog() async {
    var action = await Dialogs.yesNoDialog(
      context: pageContext,
      title: "Sorry...",
      subtitle: "Something wrong with our server, please try again later.",
    );
    if (action == DialogAction.yes) {
      print(">>> yes clicked");
    } else if (action == DialogAction.no) {
      print(">>> no clicked");
    } else {
      print(">>> else clicked");
    }
  }
}
