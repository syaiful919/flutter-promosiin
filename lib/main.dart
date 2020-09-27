import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/service/fcm/fcm_service.dart';
import 'package:base_project/service/local_notification/local_notification_service.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/utils/config.dart';
import 'package:base_project/utils/project_theme.dart';

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
  final localNotificationService = locator<LocalNotificationService>();

  @override
  void initState() {
    super.initState();
    initializePlugin();
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
        initialRoute: Routes.mainPage,
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

  void initializePlugin() async {
    try {
      configureFcm();
      configureLocalNotification();
    } catch (e) {
      print(">>> firebase init error $e");
    }
  }

  void configureFcm() async {
    await fcmService.configure(
      onMessage: (Map<String, dynamic> message) async {
        debugPrint(">>> notificatin payload: ${message['data']}");
        try {
          localNotificationService.showNotification(
            id: int.parse(message['data']['id']),
            title: message['notification']['title'],
            body: message['notification']['body'],
            payload: message['data'].toString(),
          );
        } catch (e) {
          debugPrint(">>> error $e");
        }
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

  void configureLocalNotification() async {
    await localNotificationService.initialize(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<void> onDidReceiveLocalNotification(
    int id,
    String title,
    String body,
    String payload,
  ) async {
    debugPrint(">>> onDidReceiveLocalNotification");
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint(">>> onSelectNotification: $payload");
    }
  }
}
