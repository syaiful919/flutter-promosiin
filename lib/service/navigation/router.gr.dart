// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:base_project/ui/pages/main_page/main_page.dart';
import 'package:base_project/ui/pages/create_post_page/create_post_page.dart';
import 'package:base_project/ui/pages/login_page/login_page.dart';
import 'package:base_project/ui/pages/register_page/register_page.dart';
import 'package:base_project/ui/pages/post_detail_page/post_detail_page.dart';
import 'package:base_project/ui/pages/no_internet_page/no_internet_page.dart';
import 'package:base_project/ui/pages/in_app_webview_page/in_app_webview_page.dart';
import 'package:base_project/ui/pages/widget_experiment_page/widget_experiment_page.dart';

abstract class Routes {
  static const mainPage = '/';
  static const createPostPage = '/create-post-page';
  static const loginPage = '/login-page';
  static const registerPage = '/register-page';
  static const postDetailPage = '/post-detail-page';
  static const noInternetPage = '/no-internet-page';
  static const inAppWebviewPage = '/in-app-webview-page';
  static const widgetExperimentPage = '/widget-experiment-page';
  static const all = {
    mainPage,
    createPostPage,
    loginPage,
    registerPage,
    postDetailPage,
    noInternetPage,
    inAppWebviewPage,
    widgetExperimentPage,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.mainPage:
        if (hasInvalidArgs<MainPageArguments>(args)) {
          return misTypedArgsRoute<MainPageArguments>(args);
        }
        final typedArgs = args as MainPageArguments ?? MainPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => MainPage(
              key: typedArgs.key, initialIndex: typedArgs.initialIndex),
          settings: settings,
        );
      case Routes.createPostPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CreatePostPage(),
          settings: settings,
        );
      case Routes.loginPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginPage(),
          settings: settings,
        );
      case Routes.registerPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => RegisterPage(),
          settings: settings,
        );
      case Routes.postDetailPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => PostDetailPage(),
          settings: settings,
        );
      case Routes.noInternetPage:
        if (hasInvalidArgs<NoInternetPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<NoInternetPageArguments>(args);
        }
        final typedArgs = args as NoInternetPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              NoInternetPage(typedArgs.routeName, argument: typedArgs.argument),
          settings: settings,
        );
      case Routes.inAppWebviewPage:
        if (hasInvalidArgs<InAppWebviewPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<InAppWebviewPageArguments>(args);
        }
        final typedArgs = args as InAppWebviewPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              InAppWebviewPage(redirectUrl: typedArgs.redirectUrl),
          settings: settings,
        );
      case Routes.widgetExperimentPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => WidgetExperimentPage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//MainPage arguments holder class
class MainPageArguments {
  final Key key;
  final int initialIndex;
  MainPageArguments({this.key, this.initialIndex = 0});
}

//NoInternetPage arguments holder class
class NoInternetPageArguments {
  final dynamic routeName;
  final dynamic argument;
  NoInternetPageArguments({@required this.routeName, this.argument});
}

//InAppWebviewPage arguments holder class
class InAppWebviewPageArguments {
  final String redirectUrl;
  InAppWebviewPageArguments({@required this.redirectUrl});
}
