class SelectUserCategoryRequest {
  String apikey;
  int userId;
  List<int> selectedCategory;

  SelectUserCategoryRequest(
      {required this.apikey,
      required this.userId,
      required this.selectedCategory});

  Map<String, String> toHeaders() {
    return {'Content-Type': 'application/json', 'apikey': apikey};
  }

  Map<String, String> toMap() {
    return {};
  }

  Map<String, dynamic> toBody() {
    return {
      "user_id": userId,
      "category_array": selectedCategory,
    };
  }
}
