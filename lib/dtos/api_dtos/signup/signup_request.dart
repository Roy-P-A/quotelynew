class SignUpRequest {
  String firstName;
  String lastName;
  String email;
  String password;
  String role;

  SignUpRequest(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.role});

  Map<String, String> toHeaders() {
    return {'Content-Type': 'application/json'};
  }

  Map<String, String> toMap() {
    return {};
  }

  Map<String, dynamic> toBody() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'role': role
    };
  }
}
