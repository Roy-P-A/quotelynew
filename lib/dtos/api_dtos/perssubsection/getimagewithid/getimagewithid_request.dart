class GetImageWithIdRequest {
  String imageId;

  GetImageWithIdRequest({
    required this.imageId,
  });

  Map<String, dynamic> toBody() {
    return {};
  }

  Map<String, String> toMap() {
    return {
      'image_id': imageId,
    };
  }
}
