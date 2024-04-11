class SendEmailRequest {
  String email;

  SendEmailRequest({required this.email});

  Map<String, String> toHeaders() {
    return {'Content-Type': 'application/json'};
  }

  Map<String, String> toMap() {
    return {};
  }

  Map<String, dynamic> toBody() {
    return {"email": email};
  }
}
