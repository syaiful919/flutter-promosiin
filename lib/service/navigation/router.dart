import 'package:auto_route/auto_route_annotations.dart';
import 'package:base_project/ui/pages/blank_page/blank_page.dart';
import 'package:base_project/ui/pages/home_page/home_page.dart';
import 'package:base_project/ui/pages/in_app_webview_page/in_app_webview_page.dart';
import 'package:base_project/ui/pages/multiple_stream_sample_page/multiple_stream_sample_page.dart';
import 'package:base_project/ui/pages/no_internet_page/no_internet_page.dart';
import 'package:base_project/ui/pages/stream_sample_page/stream_sample_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  HomePage homePage;
  StreamSamplePage streamSamplePage;
  MultipleStreamSamplePage multipleStreamSamplePage;
  NoInternetPage noInternetPage;
  BlankPage blankPage;
  InAppWebviewPage inAppWebviewPage;
}
