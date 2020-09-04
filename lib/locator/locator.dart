import 'package:base_project/repository/shopping_cart_repository.dart';
import 'package:base_project/service/connectivity/connectivity_service.dart';
import 'package:base_project/service/fcm/fcm_service.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/network/http_client_helper.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/repository/product_repository.dart';
import 'package:base_project/service/shared_preferences/shared_preferences_service.dart';
import 'package:base_project/service/url_launcher/url_launcher_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  SharedPreferencesService sharedPreferencesService =
      await SharedPreferencesService.getInstance();
  locator.registerSingleton<SharedPreferencesService>(sharedPreferencesService);

  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<UrlLauncherService>(UrlLauncherService());
  locator.registerSingleton<ConnectivityService>(ConnectivityService());
  locator.registerSingleton<FcmService>(FcmService());

  locator.registerSingleton<HttpClientHelper>(HttpClientHelper());

  locator.registerLazySingleton<MemberRepository>(() => MemberRepository());
  locator.registerLazySingleton<ProductRepository>(() => ProductRepository());
  locator.registerLazySingleton<ShoppingCartRepository>(
      () => ShoppingCartRepository());
}
