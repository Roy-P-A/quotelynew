import '../../../../models/perssubsection/fetchfontcolor_model.dart';
import '../../../api_response.dart';

class FetchFontColorRespnse extends ApiResponse {
  FetchFontColorRespnse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory FetchFontColorRespnse.fromJson(Map<String, dynamic> json) => FetchFontColorRespnse(
        status: json["status"],
        message: json["message"],
        data: List<FetchFontColorModel>.from(json["data"].map((x) => FetchFontColorModel.fromJson(x))),
      );
}