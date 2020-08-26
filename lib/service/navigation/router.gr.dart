// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:base_project/ui/pages/home_page/home_page.dart';
import 'package:base_project/ui/pages/stream_sample_page/stream_sample_page.dart';
import 'package:base_project/ui/pages/multiple_stream_sample_page/multiple_stream_sample_page.dart';
import 'package:base_project/ui/pages/no_internet_page/no_internet_page.dart';
import 'package:base_project/ui/pages/blank_page/blank_page.dart';

abstract class Routes {
  static const homePage = '/';
  static const streamSamplePage = '/stream-sample-page';
  static const multipleStreamSamplePage = '/multiple-stream-sample-page';
  static const noInternetPage = '/no-internet-page';
  static const blankPage = '/blank-page';
  static const all = {
    homePage,
    streamSamplePage,
    multipleStreamSamplePage,
    noInternetPage,
    blankPage,
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
      case Routes.homePage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomePage(),
          settings: settings,
        );
      case Routes.streamSamplePage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => StreamSamplePage(),
          settings: settings,
        );
      case Routes.multipleStreamSamplePage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MultipleStreamSamplePage(),
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
      case Routes.blankPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => BlankPage(),
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

//NoInternetPage arguments holder class
class NoInternetPageArguments {
  final dynamic routeName;
  final dynamic argument;
  NoInternetPageArguments({@required this.routeName, this.argument});
}
