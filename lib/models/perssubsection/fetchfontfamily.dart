class FetchFontFamilyModel {
    String fontfamilyId;
    String fontname;

    FetchFontFamilyModel({
        required this.fontfamilyId,
        required this.fontname,
    });

    factory FetchFontFamilyModel.fromJson(Map<String, dynamic> json) => FetchFontFamilyModel(
        fontfamilyId: json["fontfamily_id"],
        fontname: json["fontname"],
    );

    Map<String, dynamic> toJson() => {
        "fontfamily_id": fontfamilyId,
        "fontname": fontname,
    };
}