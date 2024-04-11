class GetImagesSubCategoryRequest {
  String pageNo;
  String pageSize;
  String parentId;

  GetImagesSubCategoryRequest({
    required this.pageNo,
    required this.pageSize,
    required this.parentId
  });

  Map<String, dynamic> toBody() {
    return {};
  }

  Map<String, String> toMap() {
    return {
      'pageNo': pageNo,
      'pageSize': pageSize,
      'parentId': parentId
    };
  }
}