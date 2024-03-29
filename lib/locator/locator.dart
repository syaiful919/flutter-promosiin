import 'package:base_project/repository/category_repository.dart';
import 'package:base_project/repository/post_repository.dart';
import 'package:base_project/repository/promotion_repository.dart';
import 'package:base_project/service/connectivity/connectivity_service.dart';
import 'package:base_project/service/fcm/fcm_service.dart';
import 'package:base_project/service/firebase_auth/firebase_auth_services.dart';
import 'package:base_project/service/firebase_storage/firebase_storage_service.dart';
import 'package:base_project/service/image_picker/image_picker_service.dart';
import 'package:base_project/service/local_notification/local_notification_service.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/repository/member_repository.dart';
import 'package:base_project/service/shared_preferences/shared_preferences_service.dart';
import 'package:base_project/service/url_launcher/url_launcher_service.dart';
import 'package:base_project/service/uuid/uuid_service.dart';
import 'package:base_project/viewmodel/home_viewmodel.dart';
import 'package:base_project/viewmodel/main_viewmodel.dart';
import 'package:base_project/viewmodel/my_account_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  SharedPreferencesService sharedPreferencesService =
      await SharedPreferencesService.getInstance();
  locator.registerSingleton<SharedPreferencesService>(sharedPreferencesService);

  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<UuidService>(UuidService());
  locator.registerSingleton<UrlLauncherService>(UrlLauncherService());
  locator.registerSingleton<ConnectivityService>(ConnectivityService());

  await Firebase.initializeApp();

  locator.registerSingleton<FcmService>(FcmService());
  locator.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
  locator.registerSingleton<FirebaseStorageService>(FirebaseStorageService());

  locator
      .registerSingleton<LocalNotificationService>(LocalNotificationService());

  locator.registerLazySingleton<ImagePickerService>(() => ImagePickerService());

  locator.registerSingleton<MemberRepository>(MemberRepository());
  locator.registerLazySingleton<PostRepository>(() => PostRepository());
  locator.registerLazySingleton<CategoryRepository>(() => CategoryRepository());
  locator
      .registerLazySingleton<PromotionRepository>(() => PromotionRepository());

  locator.registerSingleton<MainViewModel>(MainViewModel());
  locator.registerSingleton<HomeViewModel>(HomeViewModel());
  locator.registerSingleton<MyAccountViewModel>(MyAccountViewModel());
}
