import '../../../../models/dashboard/quote_fetching/quote_fetching_model.dart';
import '../../../api_response.dart';

class QuotesFetchingResponse extends ApiResponse {
  QuotesFetchingResponse({code, status, data, message})
      : super(status: status, data: data, message: message);

  factory QuotesFetchingResponse.fromJson(Map<String, dynamic> json) =>
      QuotesFetchingResponse(
        status: json["status"],
        message: json["message"],
        data: QuoteFetchingModel.fromJson(json["data"]),

      );
}