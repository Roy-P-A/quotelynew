
import '../../../models/signin/login_model.dart';
import '../../api_response.dart';

class LoginResponse extends ApiResponse {
  LoginResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        message: json["message"],
        data: LoginModel.fromJson(json["data"]),
      );
}