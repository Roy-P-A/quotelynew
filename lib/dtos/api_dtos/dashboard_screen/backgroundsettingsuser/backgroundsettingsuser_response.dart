
import '../../../../models/dashboard/backgroundsettingsuser/backgroundsetingsuser_model.dart';
import '../../../api_response.dart';

class BackgroundSettingsUserResponse extends ApiResponse {
  BackgroundSettingsUserResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory BackgroundSettingsUserResponse.fromJson(Map<String, dynamic> json) => BackgroundSettingsUserResponse(
        status: json["status"],
        message: json["message"],
        data: BackgroundSettingsUserModel.fromJson(json["data"]),
      );
}