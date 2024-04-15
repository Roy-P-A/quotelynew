import '../../../api_response.dart';

class FCMTokenResponse extends ApiResponse {
  FCMTokenResponse({status, data, message})
      : super(status: status, data: data, message: message);

  factory FCMTokenResponse.fromJson(Map<String, dynamic> json) =>
      FCMTokenResponse(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
