import 'package:base_project/locator/locator.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/service/shared_preferences/pref_keys.dart';
import 'package:base_project/service/shared_preferences/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends StreamViewModel {
  // ------ START OF INDEX TRACKING VIEWMODEL ------ //

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _reverse = false;

  /// Indicates whether we're going forward or backward in terms of the index we're changing.
  /// This is very helpful for the page transition directions.
  bool get reverse => _reverse;

  void setIndex(int value) {
    if (value < _currentIndex) {
      _reverse = true;
    } else {
      _reverse = false;
    }
    _currentIndex = value;
    notifyListeners();
  }

  bool isIndexSelected(int index) => _currentIndex == index;

  // ------ END OF INDEX TRACKING VIEWMODEL ------ //

  final _sp = locator<SharedPreferencesService>();
  final _navigationService = locator<NavigationService>();

  final _memberRepository = locator<MemberRepository>();

  bool isFirstInstall = false;
  // int onBoardingCurrentPage = 0;

  String userId;
  bool isUserLoggedIn = false;

  void firstLoad() {
    checkFirstInstall();
    checkLoginStatus();
  }

  void closeOnBoarding() {
    isFirstInstall = false;
    notifyListeners();
  }

  // void changeOnboardingPage(int val) {
  //   onBoardingCurrentPage = val;
  //   notifyListeners();
  // }

  void setPageIndex(int index) {
    if (index == 1) {
      _navigationService.pushNamed(Routes.createPostPage);
    } else if (userId == null && index == 2) {
      _navigationService.pushNamed(Routes.loginPage);
    } else {
      setIndex(index);
    }
  }

  void checkFirstInstall() {
    isFirstInstall = _sp.getBool(PrefKey.isFirstInstall);
    if (isFirstInstall == null) {
      isFirstInstall = true;
      _sp.putBool(PrefKey.isFirstInstall, false);
    }
    notifyListeners();
  }

  void checkLoginStatus() {
    setUserId();
    if (userId == null) setUserNotLogin();
  }

  setUserId() => userId = _memberRepository.getUserId();

  void setUserLogin() {
    isUserLoggedIn = true;
    notifyListeners();
  }

  void setUserNotLogin() {
    isUserLoggedIn = false;
    notifyListeners();
  }

  @override
  Stream get stream => _memberRepository.isLogin;

  @override
  void onData(data) {
    super.onData(data);
    if (data) {
      setUserId();
      setUserLogin();
    } else {
      setUserId();
      setUserNotLogin();
    }
  }
}
