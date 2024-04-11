import '../../../api_response.dart';

class ChangePasswordForgotResponse extends ApiResponse {
  ChangePasswordForgotResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory ChangePasswordForgotResponse.fromJson(Map<String, dynamic> json) => ChangePasswordForgotResponse(
        status: json["status"],
        message: json["message"],
        data: null,
      );
}