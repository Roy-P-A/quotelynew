class ColorListModel {
  String id;
  String image;
  bool isSelected;

  ColorListModel(
      {required this.id, required this.image, required this.isSelected});
}

class ColorList {
  List<ColorListModel> colorList = [
    ColorListModel(
        id: "1",
        image: "assets/images/plainbackground/colort1.png",
        isSelected: false),
    ColorListModel(
        id: "2",
        image: "assets/images/plainbackground/colort2.png",
        isSelected: false),
    ColorListModel(
        id: "3",
        image: "assets/images/plainbackground/colort3.png",
        isSelected: false),
    ColorListModel(
        id: "4",
        image: "assets/images/plainbackground/colort4.png",
        isSelected: false),
    ColorListModel(
        id: "5",
        image: "assets/images/plainbackground/colort5.png",
        isSelected: false),
    ColorListModel(
        id: "6",
        image: "assets/images/plainbackground/colort6.png",
        isSelected: false),
  ];
}
