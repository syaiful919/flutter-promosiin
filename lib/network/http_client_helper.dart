import 'dart:async';
import 'dart:convert';
import 'package:base_project/locator/locator.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/service/shared_preferences/pref_keys.dart';
import 'package:base_project/utils/config.dart';
import 'package:base_project/utils/custom_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpClientHelper {
  final _navigationService = locator<NavigationService>();

  final String _baseUrl = baseUrl();
  final client = http.Client();

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'api_key': apiKey()
  };

  bool activatedSetRoot = true;
  static const int timeout = 60;

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response =
          await client.get(_baseUrl + url, headers: headers).timeout(
                const Duration(seconds: timeout),
              );
      responseJson = await _returnResponse(response);
      return responseJson;
    } on UnauthorizedException {
      if (activatedSetRoot) {
        removeUserToken();
        _navigationService.pushNamedAndRemoveUntil(Routes.homePage);
        activatedSetRoot = false;
      }
      Future.delayed(Duration(seconds: 2), () {
        if (!activatedSetRoot) activatedSetRoot = true;
      });
    } on ServerErrorException {
      showErrorDialog();
    }
  }

  void showErrorDialog() async {}

  Future<dynamic> post({String url, dynamic body}) async {
    var responseJson;
    try {
      var response;
      if (body == null) {
        response = await client.post(_baseUrl + url, headers: headers).timeout(
              const Duration(seconds: timeout),
            );
      } else {
        response = await http
            .post(_baseUrl + url, headers: headers, body: body)
            .timeout(
              const Duration(seconds: timeout),
            );
      }

      responseJson = await _returnResponse(response);
      return responseJson;
    } on UnauthorizedException {
      if (activatedSetRoot) {
        removeUserToken();
        _navigationService.pushNamedAndRemoveUntil(Routes.homePage);
        activatedSetRoot = false;
      }
      Future.delayed(Duration(seconds: 2), () {
        if (!activatedSetRoot) activatedSetRoot = true;
      });
    }
  }

  Future<dynamic> put({String url, dynamic body}) async {
    var responseJson;
    try {
      var response;
      if (body == null) {
        response = await client.put(_baseUrl + url, headers: headers).timeout(
              const Duration(seconds: timeout),
            );
      } else {
        response = await http
            .put(_baseUrl + url, headers: headers, body: body)
            .timeout(
              const Duration(seconds: timeout),
            );
      }

      responseJson = await _returnResponse(response);
      return responseJson;
    } on UnauthorizedException {
      if (activatedSetRoot) {
        removeUserToken();
        _navigationService.pushNamedAndRemoveUntil(Routes.homePage);
        activatedSetRoot = false;
      }
      Future.delayed(Duration(seconds: 2), () {
        if (!activatedSetRoot) activatedSetRoot = true;
      });
    }
  }

  Future<dynamic> delete(String url) async {
    var responseJson;
    try {
      final response =
          await client.delete(_baseUrl + url, headers: headers).timeout(
                const Duration(seconds: timeout),
              );

      responseJson = await _returnResponse(response);
      return responseJson;
    } on UnauthorizedException {
      if (activatedSetRoot) {
        removeUserToken();
        _navigationService.pushNamedAndRemoveUntil(Routes.homePage);
        activatedSetRoot = false;
      }
      Future.delayed(Duration(seconds: 2), () {
        if (!activatedSetRoot) activatedSetRoot = true;
      });
    }
  }

  void removeUserToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(PrefKey.userToken);
  }

  String baseAuthHelper(String username, String password) =>
      "Basic " + base64Encode(utf8.encode('$username:$password'));

  dynamic _returnResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorizedException(response.body.toString());
      case 502:
        throw ServerErrorException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
