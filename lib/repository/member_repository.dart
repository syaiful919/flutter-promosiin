import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/request/login_request_model.dart';
import 'package:base_project/model/response/login_response_model.dart';
import 'package:base_project/network/api/member_api.dart';
import 'package:base_project/service/shared_preferences/pref_keys.dart';
import 'package:base_project/service/shared_preferences/shared_preferences_service.dart';

class MemberRepository {
  final MemberApi _api = MemberApi();
  final _sp = locator<SharedPreferencesService>();

  Future<LoginResponseModel> guestLogin() => _api.guestLogin();

  Future<LoginResponseModel> login(LoginRequest loginRequest) =>
      _api.login(loginRequest);

  void saveUserToken(String userToken) =>
      _sp.putString(PrefKey.userToken, userToken);
  String getUserToken() => _sp.getString(PrefKey.userToken);
  void removeUserToken() => _sp.clearKey(PrefKey.userToken);
}
