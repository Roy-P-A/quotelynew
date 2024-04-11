class GetImageCategoriesModel {
    List<GetImageCategoriesModelContent> content;
    int totalPages;
    int totalElements;
    String currentPage;
    String pageSize;

    GetImageCategoriesModel({
        required this.content,
        required this.totalPages,
        required this.totalElements,
        required this.currentPage,
        required this.pageSize,
    });

    factory GetImageCategoriesModel.fromJson(Map<String, dynamic> json) => GetImageCategoriesModel(
        content: List<GetImageCategoriesModelContent>.from(json["content"].map((x) => GetImageCategoriesModelContent.fromJson(x))),
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

class GetImageCategoriesModelContent {
    String id;
    String name;
    String parentId;
    String thumbnail;

    GetImageCategoriesModelContent({
        required this.id,
        required this.name,
        required this.parentId,
        required this.thumbnail,
    });

    factory GetImageCategoriesModelContent.fromJson(Map<String, dynamic> json) => GetImageCategoriesModelContent(
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