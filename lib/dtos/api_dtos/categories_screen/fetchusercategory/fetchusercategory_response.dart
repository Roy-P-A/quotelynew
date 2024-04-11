
import '../../../../models/categories/fetchusercategories_model.dart';
import '../../../api_response.dart';

class FetchUserCategoryResponse extends ApiResponse {
  FetchUserCategoryResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory FetchUserCategoryResponse.fromJson(Map<String, dynamic> json) => FetchUserCategoryResponse(
        status: json["status"],
        message: json["message"],
        data: FetchUserCategoriesModel.fromJson(json["data"]),
      );
}