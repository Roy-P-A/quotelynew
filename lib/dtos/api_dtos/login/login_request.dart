class LoginRequest {
  String email;
  String password;
  String role;

  LoginRequest(
      {required this.email, required this.password, required this.role});

  Map<String, String> toHeaders() {
    return {'Content-Type': 'application/json'};
  }

  Map<String, String> toMap() {
    return {};
  }

  Map<String, dynamic> toBody() {
    return {'email': email, 'password': password, 'role': role};
  }
}
