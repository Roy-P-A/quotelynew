
import '../../../../models/perssubsection/getimagewithid_model.dart';
import '../../../api_response.dart';

class GetImageWithIdResponse extends ApiResponse {
  GetImageWithIdResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory GetImageWithIdResponse.fromJson(Map<String, dynamic> json) => GetImageWithIdResponse(
        status: json["status"],
        message: json["message"],
        data: GetImageWithModel.fromJson(json["data"]),
      );
}


