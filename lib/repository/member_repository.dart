import 'dart:convert';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/model/entity/user_model.dart';
import 'package:base_project/model/request/login_request_model.dart';
import 'package:base_project/model/request/register_request_model.dart';
import 'package:base_project/model/response/auth_response_model.dart';
import 'package:base_project/network/firebase/users_collection.dart';
import 'package:base_project/service/firebase_auth/firebase_auth_services.dart';
import 'package:base_project/service/shared_preferences/pref_keys.dart';
import 'package:base_project/service/shared_preferences/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

class MemberRepository {
  final _authService = locator<FirebaseAuthServices>();
  final _sp = locator<SharedPreferencesService>();
  final UsersCollection _collection = UsersCollection();

  final BehaviorSubject<bool> _authController = BehaviorSubject<bool>();
  final BehaviorSubject<UserModel> _userController =
      BehaviorSubject<UserModel>();

  MemberRepository() {
    _authController.add(false);
  }

  void setIsLogin(bool val) => _authController.sink.add(val);
  Stream<bool> get isLogin => _authController.stream;

  void setDataStream(UserModel val) => _userController.sink.add(val);
  Stream<UserModel> get isDataChanged => _userController.stream;

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
    _collection.createUser(
      id: authResult.userId,
      user: UserModel(
        email: registerRequest.email,
        username: registerRequest.username,
      ),
    );
    return authResult;
  }

  Future<void> editUser(String userId, UserModel user) async {
    _collection.createUser(id: userId, user: user);
  }

  Future<UserModel> getUserDataRemote(String id) =>
      _collection.getUserById(id: id);

  Future<void> logOut() async {
    await _authService.signOut();
    setDataStream(null);
    removeUserId();
    removeUserData();
    setIsLogin(false);
  }

  void saveUserId(String userId) => _sp.putString(PrefKey.userId, userId);
  String getUserId() => _sp.getString(PrefKey.userId);
  void removeUserId() => _sp.clearKey(PrefKey.userId);

  void saveUserData(UserModel userData) =>
      _sp.putString(PrefKey.userData, json.encode(userData.toJson()));
  UserModel getUserData() =>
      UserModel.fromJson(json.decode(_sp.getString(PrefKey.userData)));
  void removeUserData() => _sp.clearKey(PrefKey.userData);

  void saveUserToken(String userToken) =>
      _sp.putString(PrefKey.userToken, userToken);
  String getUserToken() => _sp.getString(PrefKey.userToken);
  void removeUserToken() => _sp.clearKey(PrefKey.userToken);
}
