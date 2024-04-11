import 'package:get/get.dart';

import '../perlistingsection/widgets/abstractlist.dart';
import '../perlistingsection/widgets/colorsList.dart';
import '../perlistingsection/widgets/fontlist.dart';

class FavouritesModel {
  String id;
  String image;
  String fontFamily;
  String quote;
  bool isSelected;

  FavouritesModel(
      {required this.id,
      required this.image,
      required this.fontFamily,
      required this.quote,
      required this.isSelected});
}

class FavouritesController extends GetxController {
  String quote = "Your daily motivational quote";

  final _favourites = List<FavouritesModel>.empty(growable: true).obs;
  List<FavouritesModel> get favourites => _favourites;

  final _idvalue = 0.obs;
  int get idvalue => _idvalue.value;

  @override
  void onInit() async {
    super.onInit();

    await fetchingdata();
  }

  fetchingdata() {
    _favourites.clear();
    int fontListLength = FontList().fontList.length;
    if (idvalue == 0) {
      for (int i = 0; i < ColorList().colorList.length; i++) {
        int fontIndex = i % fontListLength;
        _favourites.add(
          FavouritesModel(
              id: ColorList().colorList[i].id,
              image: ColorList().colorList[i].image,
              fontFamily: FontList().fontList[fontIndex].fontfamily,
              quote: quote,
              isSelected: ColorList().colorList[i].isSelected),
        );
      }
    } else {
      for (int i = 0; i < ColorList().colorList.length; i++) {
        int fontIndex = i % fontListLength;
        _favourites.add(
          FavouritesModel(
              id: AbstractList().abstractList[i].id,
              image: AbstractList().abstractList[i].image,
              fontFamily: FontList().fontList[fontIndex].fontfamily,
              quote: quote,
              isSelected: AbstractList().abstractList[i].isSelected),
        );
      }
    }
  }
}
