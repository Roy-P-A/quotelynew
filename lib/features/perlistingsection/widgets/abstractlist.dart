class AbstractListModel {
  String id;
  String image;
  bool isSelected;

  AbstractListModel(
      {required this.id, required this.image, required this.isSelected});
}

class AbstractList {
  List<AbstractListModel> abstractList = [
    AbstractListModel(
        id: "1",
        image: "assets/images/abstract/abstract1.png",
        isSelected: false),
    AbstractListModel(
        id: "2",
        image: "assets/images/abstract/abstract2.png",
        isSelected: false),
    AbstractListModel(
        id: "3",
        image: "assets/images/abstract/abstract3.png",
        isSelected: false),
    AbstractListModel(
        id: "4",
        image: "assets/images/abstract/abstract4.png",
        isSelected: false),
    AbstractListModel(
        id: "5",
        image: "assets/images/abstract/abstract5.png",
        isSelected: false),
    AbstractListModel(
        id: "6",
        image: "assets/images/abstract/abstract6.png",
        isSelected: false),
  ];
}