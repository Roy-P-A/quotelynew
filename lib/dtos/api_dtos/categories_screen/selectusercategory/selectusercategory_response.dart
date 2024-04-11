
import '../../../api_response.dart';

class SelectedUserCategoryResponse extends ApiResponse {
  SelectedUserCategoryResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory SelectedUserCategoryResponse.fromJson(Map<String, dynamic> json) => SelectedUserCategoryResponse(
        status: json["status"],
        message: json["message"],
        data: null,
      );
}