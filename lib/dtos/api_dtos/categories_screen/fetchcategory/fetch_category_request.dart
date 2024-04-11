class FetchCategoryRequest {
  String apikey;
  FetchCategoryRequest({required this.apikey});

  Map<String, String> toHeaders() {
    return {'Content-Type': 'application/json', 'apikey': apikey};
  }

  Map<String, String> toMap() {
    return {};
  }

  Map<String, dynamic> toBody() {
    return {};
  }
}
