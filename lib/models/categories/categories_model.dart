class CategoriesModel {
  String categoryId;
  String categoryName;
  String categoryImageName;
  String categoryImage;
 

  CategoriesModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImageName,
    required this.categoryImage,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryImageName: json["category_image_name"],
        categoryImage: json["category_image"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_image_name": categoryImageName,
        "category_image": categoryImage,
      };
}
