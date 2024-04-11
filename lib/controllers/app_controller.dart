import 'package:flutter/material.dart';
import 'package:get/get.dart';


enum LoggedStatus { loggedInitial, notLoggedIn, loggedIn }

class AppController extends GetxController {
  static AppController get to => Get.find();
  final isLogged = LoggedStatus.loggedInitial.obs;

  @override
  onInit() {
    super.onInit();
    ever(isLogged, _fireRoute);
  }

  _fireRoute(logged) async {
    if (logged == LoggedStatus.loggedIn) {
      Get.offAllNamed("/dashboard");
    } else if (logged == LoggedStatus.notLoggedIn) {
      Get.offAllNamed("/signin");
    }
  }

  loggedIn() {
    debugPrint('loggedIn');
    isLogged.value = LoggedStatus.loggedIn;
  }

  notLoggedIn() {
    debugPrint('notloggedIn');
    isLogged.value = LoggedStatus.notLoggedIn;
  }

  loggedOut() {
    debugPrint('loggedOut');
    isLogged.value = LoggedStatus.notLoggedIn;
    Get.offAllNamed('/loginScreen');
  }
}