import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dtos/api_dtos/perssubsection/fontFamilyfetching/fetchfontfamily.dart';
import '../../dtos/api_dtos/perssubsection/fontcolorfetching/fetchfontcolor.dart';
import '../../dtos/api_dtos/perssubsection/getimagewithid/getimagewithid.dart';
import '../../dtos/api_dtos/perssubsection/sendbackgroundsettings/sendbackgroundsettings.dart';
import '../../dtos/route_dtos/perslistingsections_params.dart';
import '../../managers/sharedpreferences.dart';
import '../../mixins/snackbar_mixin.dart';
import '../../models/perssubsection/fetchfontcolor_model.dart';
import '../../models/perssubsection/fetchfontfamily.dart';
import '../../models/perssubsection/getimagewithid_model.dart';
import '../../repository/repository.dart';

class PersSubSectionController extends GetxController with SnackbarMixin {
  late PerslistingSectionsParams arguments;
  late CarouselController carouselController;
  late CarouselController carouselController1;

  String quote = "Your daily motivational quote";

  final _buttonShow1 = false.obs;
  bool get buttonShow1 => _buttonShow1.value;

  final _buttonShow2 = false.obs;
  bool get buttonShow2 => _buttonShow2.value;

  final _selectedCenterIndex = 0.obs;
  int get selectedCenterIndex => _selectedCenterIndex.value;

   final _selectedCenterIndex1 = "".obs;
  String get selectedCenterIndex1 => _selectedCenterIndex1.value;

  final _selectedCenterIndexColor = 0.obs;
  int get selectedCenterIndexColor => _selectedCenterIndexColor.value;

  final _selectedCenterIndexColor1 = "".obs;
  String get selectedCenterIndexColor1 => _selectedCenterIndexColor1.value;

  final _isLoadingFinished = false.obs;
  bool get isLoadingFinished => _isLoadingFinished.value;

  final _isLoadingColorFinished = false.obs;
  bool get isLoadingColorFinished => _isLoadingColorFinished.value;

  final _fontList1 = (List<FetchFontFamilyModel>.empty(growable: true)).obs;
  List<FetchFontFamilyModel> get fontList1 => _fontList1.value;

  final _colorList = (List<FetchFontColorModel>.empty(growable: true)).obs;
  List<FetchFontColorModel> get colorList => _colorList.value;

  final _colorList1 = (List<ColorListModel>.empty(growable: true)).obs;
  List<ColorListModel> get colorList1 => _colorList1.value;

  final _idvalue = "".obs;
  String get idvalue => _idvalue.value;

  final _isLoadingImageFinished = false.obs;
  bool get isLoadingImageFinished => _isLoadingImageFinished.value;

  final _fetchedImage = Rx<GetImageWithModel?>(null);
  GetImageWithModel? get fetchedImage => _fetchedImage.value;

  @override
  void onInit() async {
    super.onInit();
    arguments = Get.arguments;
    _idvalue.value = arguments.id;

    carouselController = CarouselController();
    carouselController1 = CarouselController();
    await initFunction();
  }

  initFunction() async {
    await fetchingImageWithId();
    await fetchingFontFamily();
    await fetchingFontColor();
  }

  editFunction() {
    _buttonShow1.value = true;
    update();
  }

  colorBurronActivate() {
    _buttonShow2.value = true;
    update();
  }

  textButtonActivate() {
    _buttonShow2.value = false;
    update();
  }

  fontSelecter(int index) {
    _selectedCenterIndex.value = index;
       debugPrint(index.toString());
     for (int i = 0; i < fontList1.length; i++) {
      if (selectedCenterIndex == i) {
        _selectedCenterIndex1.value = fontList1[i].fontfamilyId;
      }
    }
    debugPrint(selectedCenterIndex1);
    //update();
  }

  colorSelecter(int index) {
    _selectedCenterIndexColor.value = index;

    for (int i = 0; i < colorList1.length; i++) {
      if (selectedCenterIndexColor == i) {
        _selectedCenterIndexColor1.value = colorList1[i].fontColorId;
      }
    }

    //update();
  }

  fetchingImageWithId() async {
    _isLoadingImageFinished(false);
    _fetchedImage.value = null;

    try {
      final request = GetImageWithIdRequest(imageId: idvalue);
      final response = await ApiRepository.to.getImageWithId(request: request);

      if (response.status == 200) {
        _fetchedImage.value = response.data;

        _isLoadingImageFinished(true);
        update();
      } else {
        showErrorSnackbar(title: "Error", message: "Some error occured");
        _isLoadingImageFinished(true);
      }
    } catch (e) {
      _isLoadingImageFinished(true);
      showErrorSnackbar(title: "Error", message: e.toString());
    }
  }

  fetchingFontFamily() async {
    _isLoadingFinished(false);
    _fontList1.value.clear();

    try {
      final request = FetchFontFamilyRequest();
      final response = await ApiRepository.to.fetchFontFamily(request: request);

      if (response.status == 200) {
        _fontList1.value = response.data;
        //_selectedCenterIndex.value = int.parse(fontList1.first.fontfamilyId);

        if (fontList1.isNotEmpty) {
          _selectedCenterIndex1.value = fontList1.first.fontfamilyId;
        }
        _isLoadingFinished(true);
        update();
      } else {
        showErrorSnackbar(title: "Error", message: "Some error occured");
        _isLoadingFinished(true);
      }
    } catch (e) {
      _isLoadingFinished(true);
      showErrorSnackbar(title: "Error", message: e.toString());
    }
  }

  ////
  fetchingFontColor() async {
    _isLoadingColorFinished(false);
    _colorList.value.clear();
    _colorList1.value.clear();

    try {
      final request = FetchFontColorRequest();
      final response = await ApiRepository.to.fetchFontColor(request: request);

      if (response.status == 200) {
        _colorList.value = response.data;
        for (int i = 0; i < colorList.length; i++) {
          _colorList1.value.add(ColorListModel(
              fontColorId: colorList[i].fontColorId,
              fontColor: int.parse(colorList[i].fontColor)));
        }

        if (colorList1.isNotEmpty) {
          _selectedCenterIndexColor1.value = colorList1.first.fontColorId;
        }

        _isLoadingColorFinished(true);
        update();
      } else {
        showErrorSnackbar(title: "Error", message: "Some error occured");
        _isLoadingColorFinished(true);
      }
    } catch (e) {
      _isLoadingColorFinished(true);
      showErrorSnackbar(title: "Error", message: e.toString());
    }
  }

  submitFunction() async {
    final qtSharedPreferences = QTSharedPreferences();
    final apikey = await qtSharedPreferences.getApiKeyFromPrefs();
    final userId = await qtSharedPreferences.getUserIdFromPrefs();
    try {
      final request = SendBackgroundSettingsRequest(
        apikey: apikey!,
        userId: int.parse(userId!),
        backgroundimageId: int.parse(fetchedImage!.id),
        fontfamilyId: int.parse(selectedCenterIndex1),
        fontColorId: int.parse(selectedCenterIndexColor1),
      );
      final response =
          await ApiRepository.to.sendBackgroundSettings(request: request);

      if (response.status == 200) {
        await showSuccessSnackbar(
            title: "Success",
            message: "Background settings successfully updated");
        await Future.delayed(const Duration(seconds: 2), () {});
        Get.offAllNamed('/dashboard');
      } else {
        showErrorSnackbar(title: "Error", message: "Some error occured");
      }
    } catch (e) {
      showErrorSnackbar(title: "Error", message: e.toString());
    }
  }

  //////
}

class ColorListModel {
  String fontColorId;
  int fontColor;

  ColorListModel({required this.fontColorId, required this.fontColor});
}
