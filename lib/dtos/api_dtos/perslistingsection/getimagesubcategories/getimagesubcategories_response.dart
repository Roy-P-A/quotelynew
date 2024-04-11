import '../../../../models/perslistingsection/getImagesubcategory_model.dart';
import '../../../api_response.dart';

class GetImagesSubCategoryResponse extends ApiResponse {
  GetImagesSubCategoryResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory GetImagesSubCategoryResponse.fromJson(Map<String, dynamic> json) =>
      GetImagesSubCategoryResponse(
        status: json["status"],
        message: json["message"],
        data: GetImageSubCategoriesModel.fromJson(json["data"]),
      );
}