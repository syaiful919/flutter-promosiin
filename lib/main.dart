import 'package:base_project/locator/locator.dart';
import 'package:base_project/service/fcm/fcm_service.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/utils/config.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final fcmService = locator<FcmService>();

  @override
  void initState() {
    super.initState();
    configureFcm();
  }

  void configureFcm() async {
    await fcmService.configure(
      onMessage: (Map<String, dynamic> message) async {
        debugPrint('>>> onMessage: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        debugPrint('>>> onResume: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        debugPrint('>>> onLaunch: $message');
      },
    );

    fcmService.subscribeToTopic(firebaseTopic());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: ProjectConfig.projectName,
        theme: projectTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Router().onGenerateRoute,
        initialRoute: Routes.homePage,
        navigatorKey: locator<NavigationService>().navigationKey,
        builder: (context, widget) => Navigator(
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Builder(builder: (context) => widget),
            ),
          ),
        ),
      ),
    );
  }
}
