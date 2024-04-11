import '../../../../models/forgotpassword/sendresettoken_model.dart';
import '../../../api_response.dart';

class SendResetTokenResponse extends ApiResponse {
  SendResetTokenResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory SendResetTokenResponse.fromJson(Map<String, dynamic> json) => SendResetTokenResponse(
        status: json["status"],
        message: json["message"],
        data: SendResetTokenModel.fromJson(json["data"]),
      );
}