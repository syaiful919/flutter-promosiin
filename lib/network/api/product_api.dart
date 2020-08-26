import 'dart:convert';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/network/http_client_helper.dart';

class ProductApi {
  final _helper = locator<HttpClientHelper>();
}