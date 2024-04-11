class FetchUserCategoriesModel {
    List<FetchUserCategoriesContentModel> content;

    FetchUserCategoriesModel({
        required this.content,
    });

    factory FetchUserCategoriesModel.fromJson(Map<String, dynamic> json) => FetchUserCategoriesModel(
        content: List<FetchUserCategoriesContentModel>.from(json["content"].map((x) => FetchUserCategoriesContentModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
    };
}

class FetchUserCategoriesContentModel {
    String categoryId;

    FetchUserCategoriesContentModel({
        required this.categoryId,
    });

    factory FetchUserCategoriesContentModel.fromJson(Map<String, dynamic> json) => FetchUserCategoriesContentModel(
        categoryId: json["category_id"],
    );

    Map<String, dynamic> toJson() => {
        "category_id": categoryId,
    };
}