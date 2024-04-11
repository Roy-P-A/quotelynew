class ChangePasswordForgotRequest {
  String id;
  String userId;
  String token;
  String apikey;
  String password;

  ChangePasswordForgotRequest(
      {required this.id,
      required this.userId,
      required this.token,
      required this.apikey,
      required this.password});

  Map<String, String> toHeaders() {
    return {'Content-Type': 'application/json'};
  }

  Map<String, String> toMap() {
    return {};
  }

  Map<String, dynamic> toBody() {
    return {
      "id": id,
      "user_id": userId,
      "token": token,
      "apikey": apikey,
      "password": password
    };
  }
}
