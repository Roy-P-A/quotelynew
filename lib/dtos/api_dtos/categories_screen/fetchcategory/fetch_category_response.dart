import '../../../../models/categories/categories_model.dart';
import '../../../api_response.dart';

class FetchCategoryResponse extends ApiResponse {
  FetchCategoryResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory FetchCategoryResponse.fromJson(Map<String, dynamic> json) => FetchCategoryResponse(
        status: json["status"],
        message: json["message"],
        data: List<CategoriesModel>.from(json["data"].map((x) => CategoriesModel.fromJson(x))),
      );
}