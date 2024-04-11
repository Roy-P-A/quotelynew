class BackgroundSettingsUserRequest {
  String apikey;
  String userId;
  BackgroundSettingsUserRequest({required this.apikey,required this.userId});

  Map<String, String> toHeaders() {
    return {'Content-Type': 'application/json', 'apikey': apikey};
  }

  String toId() {
    return userId;
  }

  Map<String, String> toMap() {
    return {};
  }

  Map<String, dynamic> toBody() {
    return {
      "user_id":userId
    };
  }
}