import 'package:get/get.dart';

import '../../controllers/app_controller.dart';

import '../../managers/sharedpreferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    checkIfUserLoggedin();
    super.onInit();
  }

  checkIfUserLoggedin() async {
    await Future.delayed(const Duration(milliseconds: 3000));

    //final bool isAlreadyRun = await HiveHelper.to.isAppAlreadyRun();
    final qtSharedPreferences = QTSharedPreferences();
    final apikey = await qtSharedPreferences.getApiKeyFromPrefs() ?? "";

    if (apikey.isNotEmpty) {
      AppController.to.loggedIn();
    } else {
      AppController.to.notLoggedIn();
    }
  }
}
