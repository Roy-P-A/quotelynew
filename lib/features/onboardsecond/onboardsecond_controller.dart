import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../dtos/api_dtos/categories_screen/fetchcategory/fetch_category.dart';
import '../../dtos/api_dtos/categories_screen/fetchusercategory/fetchusercategory.dart';
import '../../dtos/api_dtos/categories_screen/selectusercategory/selectusercategory.dart';
import '../../managers/sharedpreferences.dart';
import '../../mixins/snackbar_mixin.dart';
import '../../models/categories/categories_model.dart';
import '../../models/categories/fetchusercategories_model.dart';
import '../../repository/api_repository.dart';

class OnboardSecondController extends GetxController with SnackbarMixin {
  final _isLoadingCategoryFinished = false.obs;
  bool get isLoadingCategoryFinished => _isLoadingCategoryFinished.value;

  final _isLoadingUserCategoryFinished = false.obs;
  bool get isLoadingUserCategoryFinished =>
      _isLoadingUserCategoryFinished.value;

  final _categoryFetch = (List<CategoriesModel>.empty(growable: true)).obs;
  List<CategoriesModel> get categoryFetch => _categoryFetch.value;

  final _categoryFetchConverted =
      (List<CategoriesModelConverted>.empty(growable: true)).obs;
  List<CategoriesModelConverted> get categoryFetchConverted =>
      _categoryFetchConverted.value;

  final _preUsercategoryFetch = Rx<FetchUserCategoriesModel?>(null);
  FetchUserCategoriesModel? get preUsercategoryFetch =>
      _preUsercategoryFetch.value;

  final _preUsercategoryContentFetch =
      (List<FetchUserCategoriesContentModel>.empty(growable: true)).obs;
  List<FetchUserCategoriesContentModel> get preUsercategoryContentFetch =>
      _preUsercategoryContentFetch.value;

  final _categorySelected = (List<int>.empty(growable: true)).obs;
  List<int> get categorySelected => _categorySelected.value;

  final _numberOfCategorySelected = 0.obs;
  int get numberOfCategorySelected => _numberOfCategorySelected.value;

  final _totalCategories = 0.obs;
  int get totalCategories => _totalCategories.value;

  @override
  void onInit() async {
    super.onInit();
    await initFunction();
  }

  initFunction() async {
    await fetchingCategory();
  }

  fetchingCategory() async {
    _isLoadingCategoryFinished(false);
    _categoryFetch.value.clear();
    _categoryFetchConverted.value.clear();
    _totalCategories.value = 0;

    try {
      final request = FetchCategoryRequest(apikey: "apikey");
      final response = await ApiRepository.to.fetchCategory(request: request);

      if (response.status == 200) {
        _categoryFetch.value = response.data;
        for (int i = 0; i < categoryFetch.length; i++) {
          _categoryFetchConverted.add(CategoriesModelConverted(
              categoryId: categoryFetch[i].categoryId,
              categoryName: categoryFetch[i].categoryName,
              categoryImageName: categoryFetch[i].categoryImageName,
              categoryImage: categoryFetch[i].categoryImage,
              isSelected: false));
        }

        _totalCategories.value = categoryFetchConverted.length;

        debugPrint(_categoryFetchConverted.value.toString());

        _isLoadingCategoryFinished(true);
        update();
      } else {
        showErrorSnackbar(title: "Error", message: "Some error occured");
        _isLoadingCategoryFinished(true);
      }
    } catch (e) {
      _isLoadingCategoryFinished(true);
      showErrorSnackbar(title: "Error", message: e.toString());
    }
  }

  tapCategory(CategoriesModelConverted category) {
    if (category.isSelected == true) {
      for (int i = 0; i < categoryFetchConverted.length; i++) {
        if (categoryFetchConverted[i].categoryId == category.categoryId) {
          categoryFetchConverted[i].isSelected = false;
        }
        update();
      }
    } else {
      for (int i = 0; i < categoryFetchConverted.length; i++) {
        if (categoryFetchConverted[i].categoryId == category.categoryId) {
          categoryFetchConverted[i].isSelected = true;
        }
        update();
      }
    }
    _numberOfCategorySelected.value = 0;
    for (int i = 0; i < categoryFetchConverted.length; i++) {
      if (categoryFetchConverted[i].isSelected == true) {
        _numberOfCategorySelected.value = numberOfCategorySelected + 1;
      }
    }
  }

  sendingSelectedCategory() async {
    _isLoadingUserCategoryFinished(false);

    for (int i = 0; i < categoryFetchConverted.length; i++) {
      if (categoryFetchConverted[i].isSelected == true) {
        _categorySelected.add(int.parse(categoryFetchConverted[i].categoryId));
      }
    }

    final qtSharedPreferences = QTSharedPreferences();
    final apikey = await qtSharedPreferences.getApiKeyFromPrefs();
    final userId = await qtSharedPreferences.getUserIdFromPrefs();

    try {
      final request = SelectUserCategoryRequest(
          apikey: apikey!,
          userId: int.parse(userId!),
          selectedCategory: categorySelected);
      final response =
          await ApiRepository.to.selectUserCategory(request: request);

      if (response.status == 200) {
        await showSuccessSnackbar(
            title: "Success", message: "Category successfully updated ");

        _isLoadingUserCategoryFinished(true);
        update();
      } else {
        showErrorSnackbar(title: "Error", message: "Some error occured");
        _isLoadingUserCategoryFinished(true);
      }
    } catch (e) {
      _isLoadingUserCategoryFinished(true);
      showErrorSnackbar(title: "Error", message: e.toString());
    }
  }
}

class CategoriesModelConverted {
  String categoryId;
  String categoryName;
  String categoryImageName;
  String categoryImage;
  bool isSelected;

  CategoriesModelConverted(
      {required this.categoryId,
      required this.categoryName,
      required this.categoryImageName,
      required this.categoryImage,
      required this.isSelected});
}
