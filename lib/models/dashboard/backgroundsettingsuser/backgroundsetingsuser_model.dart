class BackgroundSettingsUserModel {
    String userId;
    String fontfamilyId;
    String fontname;
    String backgroundId;
    String backgroundName;
    String backgroundOriginalImage;
    String fontcolorId;
    String fontcolor;
    String image;

    BackgroundSettingsUserModel({
        required this.userId,
        required this.fontfamilyId,
        required this.fontname,
        required this.backgroundId,
        required this.backgroundName,
        required this.backgroundOriginalImage,
        required this.fontcolorId,
        required this.fontcolor,
        required this.image,
    });

    factory BackgroundSettingsUserModel.fromJson(Map<String, dynamic> json) => BackgroundSettingsUserModel(
        userId: json["user_id"],
        fontfamilyId: json["fontfamily_id"],
        fontname: json["fontname"],
        backgroundId: json["background_id"],
        backgroundName: json["background_name"],
        backgroundOriginalImage: json["background_original_image"],
        fontcolorId: json["fontcolor_id"],
        fontcolor: json["fontcolor"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "fontfamily_id": fontfamilyId,
        "fontname": fontname,
        "background_id": backgroundId,
        "background_name": backgroundName,
        "background_original_image": backgroundOriginalImage,
        "fontcolor_id": fontcolorId,
        "fontcolor": fontcolor,
        "image": image,
    };
}