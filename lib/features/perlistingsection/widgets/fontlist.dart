class FontListModel {
  String fontfamily;

  FontListModel({
    required this.fontfamily,
  });
}

class FontList {
  List<FontListModel> fontList = [
    FontListModel(fontfamily: "PlusJakartaSans"),
    FontListModel(fontfamily: "Caveat"),
    FontListModel(fontfamily: "GochiHand"),
    FontListModel(fontfamily: "AnnieUseYourTelescope"),
    FontListModel(fontfamily: "PlayfairDisplay"),
    FontListModel(fontfamily: "McLaren"),
    FontListModel(fontfamily: "Lora"),
    FontListModel(fontfamily: "JosefinSans"),
    FontListModel(fontfamily: "CherrySwash"),
  ];
}
