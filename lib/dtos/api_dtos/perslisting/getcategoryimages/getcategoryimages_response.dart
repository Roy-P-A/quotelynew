import '../../../../models/perslisting/getimagescategory_model.dart';
import '../../../api_response.dart';

class GetCategoryImagesResponse extends ApiResponse {
  GetCategoryImagesResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory GetCategoryImagesResponse.fromJson(Map<String, dynamic> json) =>
      GetCategoryImagesResponse(
        status: json["status"],
        message: json["message"],
        data: GetImageCategoriesModel.fromJson(json["data"]),
      );
}
