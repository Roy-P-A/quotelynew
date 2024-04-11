

class CategoryListModel {
  String id;
  String title;
  String image;
  bool isSelected;

  CategoryListModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.isSelected});
}

class CategoryList {
  List<CategoryListModel> quoteList = [
    CategoryListModel(
        id: "1",
        title: "Happiness",
        image: "assets/images/categories/happiness.png",
        isSelected: false),
    CategoryListModel(
        id: "2",
        title: "Productivity",
        image: "assets/images/categories/productivity.png",
        isSelected: true),
    CategoryListModel(
        id: "3",
        title: "Motivation",
        image: "assets/images/categories/motivation.png",
        isSelected: false),
    CategoryListModel(
        id: "4",
        title: "Success",
        image: "assets/images/categories/success.png",
        isSelected: false),
    CategoryListModel(
        id: "5",
        title: "Mindfulness",
        image: "assets/images/categories/motivation.png",
        isSelected: false),
    CategoryListModel(
        id: "6",
        title: "Health",
        image: "assets/images/categories/health.png",
        isSelected: false),
  ];
}
