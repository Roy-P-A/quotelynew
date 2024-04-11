

import '../../../../models/perssubsection/fetchfontfamily.dart';
import '../../../api_response.dart';

class FetchFontFamilyRespnse extends ApiResponse {
  FetchFontFamilyRespnse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory FetchFontFamilyRespnse.fromJson(Map<String, dynamic> json) => FetchFontFamilyRespnse(
        status: json["status"],
        message: json["message"],
        data: List<FetchFontFamilyModel>.from(json["data"].map((x) => FetchFontFamilyModel.fromJson(x))),
      );
}