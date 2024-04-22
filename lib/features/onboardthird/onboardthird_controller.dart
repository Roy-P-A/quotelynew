

import 'package:flutter/widgets.dart';

import '../../dtos/api_dtos/perslisting/getcategoryimages/getcategoryimages.dart';
import '../../dtos/route_dtos/perslisting_params.dart';
import '../../mixins/snackbar_mixin.dart';
import 'package:get/get.dart';

import '../../models/perslisting/getimagescategory_model.dart';
import '../../repository/repository.dart';

class OnboardThirdController extends GetxController with SnackbarMixin {
  final scrollController = ScrollController();

  final _isLoadingFetchImageCategories = false.obs;
  bool get isLoadingFetchImageCategories =>
      _isLoadingFetchImageCategories.value;

  final _isPageno = 0.obs;
  int get isPageno => _isPageno.value;

  final _getImageCategoriesData = Rx<GetImageCategoriesModel?>(null);
  GetImageCategoriesModel? get getImageCategoriesData =>
      _getImageCategoriesData.value;

  final _getImageCategoriesDataContent =
      (List<GetImageCategoriesModelContent>.empty()).obs;
  List<GetImageCategoriesModelContent> get getImageCategoriesDataContent =>
      _getImageCategoriesDataContent;

  @override
  void onInit() async {
    await initialFetching();
    scrollController.addListener(() {
      if (!isLoadingFetchImageCategories &&
          scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
        fetchOtherPage();
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> initialFetching() async {
    _getImageCategoriesDataContent.clear();

    await fetchImageCategories();
  }

  fetchOtherPage() async {
    if (_getImageCategoriesData != null) {
      if (isPageno < getImageCategoriesData!.totalPages) {
        await fetchImageCategories();
      } else {}
    }
  }

  fetchImageCategories() async {
    _getImageCategoriesData.value = null;
    _isLoadingFetchImageCategories.value = true;

    try {
      final request = GetCategoryImagesRequest(
        pageNo: isPageno.toString(),
        pageSize: '15',
      );
      final response =
          await ApiRepository.to.getImageCategories(request: request);

      if (response.status == 200) {
        _getImageCategoriesData.value = response.data;

        if (getImageCategoriesData!.content.isNotEmpty) {
          for (int i = 0; i < getImageCategoriesData!.content.length; i++) {
            _getImageCategoriesDataContent
                .add(getImageCategoriesData!.content[i]);
          }
        } else {}

        _isPageno.value = _isPageno.value + 1;
        _isLoadingFetchImageCategories.value = false;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
      _isLoadingFetchImageCategories.value = false;
    }
  }

  selectPersonalizeListView(String value,String name) {
    Get.toNamed('/onboardfourth', arguments: PerslistingParams(id: value,name: name));
  }
}