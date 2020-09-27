import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/request/login_request_model.dart';
import 'package:base_project/model/request/register_request_model.dart';
import 'package:base_project/model/response/auth_response_model.dart';
import 'package:base_project/service/firebase_auth/firebase_auth_services.dart';
import 'package:base_project/service/shared_preferences/pref_keys.dart';
import 'package:base_project/service/shared_preferences/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

class MemberRepository {
  final _authService = locator<FirebaseAuthServices>();
  final _sp = locator<SharedPreferencesService>();
  final BehaviorSubject<bool> _authController = BehaviorSubject<bool>();

  MemberRepository() {
    _authController.add(false);
  }

  void setIsLogin(bool val) => _authController.sink.add(val);
  Stream<bool> get isLogin => _authController.stream;

  Future<AuthResponseModel> login(LoginRequestModel loginRequest) async {
    AuthResponseModel authResult = await _authService.signIn(
      email: loginRequest.email,
      password: loginRequest.password,
    );
    return authResult;
  }

  Future<AuthResponseModel> register(
      RegisterRequestModel registerRequest) async {
    AuthResponseModel authResult = await _authService.signUp(
      email: registerRequest.email,
      password: registerRequest.password,
    );
    return authResult;
  }

  Future<void> logOut() async {
    await _authService.signOut();
    removeUserId();
    setIsLogin(false);
  }

  void saveUserId(String userId) => _sp.putString(PrefKey.userId, userId);
  String getUserId() => _sp.getString(PrefKey.userId);
  void removeUserId() => _sp.clearKey(PrefKey.userId);

  void saveUserToken(String userToken) =>
      _sp.putString(PrefKey.userToken, userToken);
  String getUserToken() => _sp.getString(PrefKey.userToken);
  void removeUserToken() => _sp.clearKey(PrefKey.userToken);
}
