class GetImageWithModel {
    String id;
    String name;
    String parentId;
    String imageName;
    String image;

    GetImageWithModel({
        required this.id,
        required this.name,
        required this.parentId,
        required this.imageName,
        required this.image,
    });

    factory GetImageWithModel.fromJson(Map<String, dynamic> json) => GetImageWithModel(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"],
        imageName: json["image_name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "image_name": imageName,
        "image": image,
    };
}