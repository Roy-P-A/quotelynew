class SendBackgroundSettingsRequest {
  String apikey;
  int userId;
  int backgroundimageId;
  int fontfamilyId;
  int fontColorId;

  SendBackgroundSettingsRequest(
      {required this.apikey,
      required this.userId,
      required this.backgroundimageId,
      required this.fontfamilyId,
      required this.fontColorId});

  Map<String, String> toHeaders() {
    return {'Content-Type': 'application/json', 'apikey': apikey};
  }

  Map<String, String> toMap() {
    return {};
  }

  Map<String, dynamic> toBody() {
    return {
      'userid': userId,
      'backgroundimageid': backgroundimageId,
      'fontfamilyid': fontfamilyId,
      'fontcolorid': fontColorId
    };
  }
}
