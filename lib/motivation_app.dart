import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'config/app/app_config.dart';
import 'controllers/app_controller.dart';
import 'controllers/themes_controller/theme_controller.dart';
import 'managers/firebase_api/firebase_api.dart';
import 'repository/api_repository.dart';
import 'utils/constants/app_texts.dart';
import 'utils/utils.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

Future<void> initMotivationApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: QTAppConfigManager.config.fireBaseApiKey,
        appId: QTAppConfigManager.config.firebaseappId,
        messagingSenderId: QTAppConfigManager.config.firebasemessagingSenderId,
        projectId: QTAppConfigManager.config.firebaseprojectId),
   
  );
  //https://quotely-7f787.firebaseapp.com/__/auth/handler////////facebook
  await FirebaseApi().initNotifications();
  // InAppPurchaseConnection.enablePendingPurchases();
  MobileAds.instance.initialize();

  await Future.wait<void>([
    initializeAppControllers(),
  ]);
}

Future<void> initializeAppControllers() async {
  Get.put(AppController(), permanent: true);
  debugPrint("MotivationApp : AppController sucessfully initialized");
  Get.put<ApiRepository>(ApiRepositoryImpl(), permanent: true);
  debugPrint("MotivationApp : ApiRepositoryImpl sucessfully initialized");
  Get.put<ThemeController>(ThemeController(), permanent: true);
  debugPrint("MotivationApp : Themecontroller sucessfully initialized");
}

class MotivationApp extends StatelessWidget {
  const MotivationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: ktitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      navigatorObservers: [
        DismissKeyboardNavigationObserver(),
        NavigatorObserverWithOrientation(),
      ],
      getPages: routes(),
    );
  }
}

class DismissKeyboardNavigationObserver extends NavigatorObserver {
  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.didStartUserGesture(route, previousRoute);
  }
}
