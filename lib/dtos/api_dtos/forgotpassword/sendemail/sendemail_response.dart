import '../../../api_response.dart';

class SendEmailResponse extends ApiResponse {
  SendEmailResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory SendEmailResponse.fromJson(Map<String, dynamic> json) => SendEmailResponse(
        status: json["status"],
        message: json["message"],
        data: null,
      );
}