import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

import '../../dtos/api_dtos/notifications/fcm_tocken/fcm_token.dart';
import '../../repository/repository.dart';

class FCMTokenManager {
  static Future<void> _registerFCMToken(String? fcmFirebaseToken) async {
    try {
      final request = FCMTokenRequest(fcmFirebaseToken: fcmFirebaseToken!);
      final response = await ApiRepository.to.fcmTokenRefresh(request: request);
      if (response.status == 200) {
        var myResponse = response.message;

        debugPrint("success ");
      } else {
        debugPrint("Error");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static void registerTokenOne() async {
    await FirebaseMessaging.instance
        .getToken()
        .then((value) => _registerFCMToken(value));
  }

  static void registerToken() async {
    await FirebaseMessaging.instance
        .getToken()
        .then((value) => _registerFCMToken(value));
    FirebaseMessaging.instance.onTokenRefresh.listen(_registerFCMToken);
  }
}
