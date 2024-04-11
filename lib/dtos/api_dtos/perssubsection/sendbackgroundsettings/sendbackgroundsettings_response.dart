import '../../../api_response.dart';

class SendBackgroundSettingsResponse extends ApiResponse {
  SendBackgroundSettingsResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory SendBackgroundSettingsResponse.fromJson(Map<String, dynamic> json) =>
      SendBackgroundSettingsResponse(
        status: json["status"],
        message: json["message"],
        data: null,
      );
}
