class FetchFontColorModel {
    String fontColorId;
    String fontColor;

    FetchFontColorModel({
        required this.fontColorId,
        required this.fontColor,
    });

    factory FetchFontColorModel.fromJson(Map<String, dynamic> json) => FetchFontColorModel(
        fontColorId: json["fontcolor_id"],
        fontColor: json["fontcolor"],
    );

    Map<String, dynamic> toJson() => {
        "fontcolor_id": fontColorId,
        "fontcolor": fontColor,
    };
}