import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dtos/api_dtos/perslistingsection/getimagesubcategories/getimagesubcategories.dart';
import '../../dtos/api_dtos/perssubsection/fontFamilyfetching/fetchfontfamily.dart';
import '../../dtos/route_dtos/perslisting_params.dart';
import '../../dtos/route_dtos/perslistingsections_params.dart';
import '../../mixins/snackbar_mixin.dart';
import '../../models/perslistingsection/getImagesubcategory_model.dart';
import '../../models/perssubsection/fetchfontfamily.dart';
import '../../repository/repository.dart';

class PersListingsectionModel {
  String id;
  String image;
  String fontFamily;
  String quote;
  bool isSelected;

  PersListingsectionModel(
      {required this.id,
      required this.image,
      required this.fontFamily,
      required this.quote,
      required this.isSelected});
}

class PerslistingSectionController extends GetxController with SnackbarMixin {
  late PerslistingParams arguments;

  String quote = "Your daily motivational quote";

  final _header = "".obs;
  String get header => _header.value;

  final _idvalue = "".obs;
  String get idvalue => _idvalue.value;

  final scrollController = ScrollController();

  final _isLoadingFetchImageSubCategories = false.obs;
  bool get isLoadingFetchImageSubCategories =>
      _isLoadingFetchImageSubCategories.value;

  final _isPageno = 0.obs;
  int get isPageno => _isPageno.value;

  final _getImageSubCategoriesData = Rx<GetImageSubCategoriesModel?>(null);
  GetImageSubCategoriesModel? get getImageSubCategoriesData =>
      _getImageSubCategoriesData.value;

  final _getImageSubCategoriesDataContent =
      (List<GetImageSubCategoriesModelContent>.empty()).obs;
  List<GetImageSubCategoriesModelContent>
      get getImageSubCategoriesDataContent => _getImageSubCategoriesDataContent;

  final _persListingsection =
      List<PersListingsectionModel>.empty(growable: true).obs;
  List<PersListingsectionModel> get persListingsection => _persListingsection;

  final _isLoadingFontFamilyFinished = false.obs;
  bool get isLoadingFontFamilyFinished => _isLoadingFontFamilyFinished.value;

  final _fontList1 = (List<FetchFontFamilyModel>.empty(growable: true)).obs;
  List<FetchFontFamilyModel> get fontList1 => _fontList1.value;

  @override
  void onInit() async {
    super.onInit();
    arguments = Get.arguments;
    _idvalue.value = arguments.id;
    _header.value = arguments.name;
    await fetchingFontFamily();
    await initialFetching();
    scrollController.addListener(() {
      if (!isLoadingFetchImageSubCategories &&
          scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
        fetchOtherPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  fetchingFontFamily() async {
    _isLoadingFontFamilyFinished(false);
    _fontList1.value.clear();

    try {
      final request = FetchFontFamilyRequest();
      final response = await ApiRepository.to.fetchFontFamily(request: request);

      if (response.status == 200) {
        _fontList1.value = response.data;
        //_selectedCenterIndex.value = int.parse(fontList1.first.fontfamilyId);
        _isLoadingFontFamilyFinished(true);
        update();
      } else {
        showErrorSnackbar(title: "Error", message: "Some error occured");
        _isLoadingFontFamilyFinished(true);
      }
    } catch (e) {
      _isLoadingFontFamilyFinished(true);
      showErrorSnackbar(title: "Error", message: e.toString());
    }
  }

  Future<void> initialFetching() async {
    _getImageSubCategoriesDataContent.clear();

    await fetchImageSubCategories();
  }

  fetchOtherPage() async {
    if (_getImageSubCategoriesData != null) {
      if (isPageno < getImageSubCategoriesData!.totalPages) {
        await fetchImageSubCategories();
      } else {}
    }
  }

  fetchImageSubCategories() async {
    _getImageSubCategoriesData.value = null;
    _isLoadingFetchImageSubCategories.value = true;

    try {
      final request = GetImagesSubCategoryRequest(
        parentId: idvalue,
        pageNo: isPageno.toString(),
        pageSize: '15',
      );
      final response =
          await ApiRepository.to.getImageSubCategories(request: request);

      if (response.status == 200) {
        _getImageSubCategoriesData.value = response.data;

        if (getImageSubCategoriesData!.content.isNotEmpty) {
          for (int i = 0; i < getImageSubCategoriesData!.content.length; i++) {
            _getImageSubCategoriesDataContent
                .add(getImageSubCategoriesData!.content[i]);
          }
          await convertedFetchedData();
        } else {}

        _isPageno.value = _isPageno.value + 1;
        _isLoadingFetchImageSubCategories.value = false;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
      _isLoadingFetchImageSubCategories.value = false;
    }
  }

  ///

  convertedFetchedData() async {
    _persListingsection.clear();
    int fontListLength = fontList1.length;

    for (int i = 0; i < getImageSubCategoriesDataContent.length; i++) {
      int fontIndex = i % fontListLength;
      _persListingsection.add(
        PersListingsectionModel(
            id: getImageSubCategoriesDataContent[i].id,
            image: getImageSubCategoriesDataContent[i].thumbnail,
            fontFamily: fontList1[fontIndex].fontname,
            quote: quote,
            isSelected: false),
      );
    }
  }

  ///
  prelistingSub(String id) {
    Get.toNamed("/perslistingsub",
        arguments: PerslistingSectionsParams(id: id));
  }

  ///
}
