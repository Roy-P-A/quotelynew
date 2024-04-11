class GetImageSubCategoriesModel {
    List<GetImageSubCategoriesModelContent> content;
    int totalPages;
    int totalElements;
    String currentPage;
    String pageSize;

    GetImageSubCategoriesModel({
        required this.content,
        required this.totalPages,
        required this.totalElements,
        required this.currentPage,
        required this.pageSize,
    });

    factory GetImageSubCategoriesModel.fromJson(Map<String, dynamic> json) => GetImageSubCategoriesModel(
        content: List<GetImageSubCategoriesModelContent>.from(json["content"].map((x) => GetImageSubCategoriesModelContent.fromJson(x))),
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "totalPages": totalPages,
        "totalElements": totalElements,
        "currentPage": currentPage,
        "pageSize": pageSize,
    };
}

class GetImageSubCategoriesModelContent {
    String id;
    String name;
    String parentId;
    String thumbnail;

    GetImageSubCategoriesModelContent({
        required this.id,
        required this.name,
        required this.parentId,
        required this.thumbnail,
    });

    factory GetImageSubCategoriesModelContent.fromJson(Map<String, dynamic> json) => GetImageSubCategoriesModelContent(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "thumbnail": thumbnail,
    };
}