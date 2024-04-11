import '../../../models/signup/signup_model.dart';
import '../../api_response.dart';

class SignUpResponse extends ApiResponse {
  SignUpResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        status: json["status"],
        message: json["message"],
        data: SignUpModel.fromJson(json["data"]),
      );
}
