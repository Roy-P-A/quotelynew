

class PersListModel {
  String id;
  String title;
  String image;

  PersListModel({
    required this.id,
    required this.title,
    required this.image,
  });
}

class PersList {
  List<PersListModel> persList = [
    PersListModel(
      id: "1",
      title: "Colors",
      image: "assets/images/personalize/colors.png",
    ),
     PersListModel(
      id: "2",
      title: "Abstract",
      image: "assets/images/personalize/abstract.png",
    ),
     PersListModel(
      id: "3",
      title: "Animals",
      image: "assets/images/personalize/animals.png",
    ),
     PersListModel(
      id: "4",
      title: "Nature",
      image: "assets/images/personalize/nature.png",
    ),
     PersListModel(
      id: "5",
      title: "Space",
      image: "assets/images/personalize/space.png",
    ),
    PersListModel(
      id: "6",
      title: "Videos",
      image: "assets/images/personalize/videos.png",
    ),
  ];
}
