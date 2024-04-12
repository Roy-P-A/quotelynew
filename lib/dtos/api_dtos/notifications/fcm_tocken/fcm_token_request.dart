class FCMTokenRequest {
  String fcmFirebaseToken;

  FCMTokenRequest({required this.fcmFirebaseToken});

  Map<String, String> toMap() {
    return {
      "token": fcmFirebaseToken,
    };
  }
}
