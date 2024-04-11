class GetCategoryImagesRequest {
  String pageNo;
  String pageSize;

  GetCategoryImagesRequest({
    required this.pageNo,
    required this.pageSize,
  });

  Map<String, dynamic> toBody() {
    return {};
  }

  Map<String, String> toMap() {
    return {
      'pageNo': pageNo,
      'pageSize': pageSize,
    };
  }
}
