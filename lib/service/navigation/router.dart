import 'package:auto_route/auto_route_annotations.dart';
import 'package:base_project/ui/pages/category_page/category_page.dart';
import 'package:base_project/ui/pages/create_post_page/create_post_page.dart';
import 'package:base_project/ui/pages/in_app_webview_page/in_app_webview_page.dart';
import 'package:base_project/ui/pages/login_page/login_page.dart';
import 'package:base_project/ui/pages/main_page/main_page.dart';
import 'package:base_project/ui/pages/no_internet_page/no_internet_page.dart';
import 'package:base_project/ui/pages/post_detail_page/post_detail_page.dart';
import 'package:base_project/ui/pages/register_page/register_page.dart';
import 'package:base_project/ui/pages/widget_experiment_page/widget_experiment_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  MainPage mainPage;
  CreatePostPage createPostPage;
  LoginPage loginPage;
  RegisterPage registerPage;
  PostDetailPage postDetailPage;
  CategoryPage categoryPage;

  NoInternetPage noInternetPage;
  InAppWebviewPage inAppWebviewPage;
  WidgetExperimentPage widgetExperimentPage;
}
