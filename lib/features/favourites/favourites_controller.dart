import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

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
  final _favourites = List<FavouritesModel>.empty(growable: true).obs;
  List<FavouritesModel> get favourites => _favourites;

  final _idvalue = 0.obs;
  int get idvalue => _idvalue.value;

  final _isLoadingShare = false.obs;
  bool get isLoadingShare => _isLoadingShare.value;

  final _isModified = false.obs;
  bool get isModified => _isModified.value;

  @override
  void onInit() async {
    super.onInit();

    await fetchingdata();
  }

  fetchingdata() {}

  shareImageToSocialMedia1(GlobalKey key) async {
    _isLoadingShare.value = true;
    _isModified.value = true;
   // update();
    await Future.delayed(const Duration(seconds: 2));
    
    final RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/screenshot.png';
    File(tempPath).writeAsBytesSync(pngBytes);

    try {
      final result = await Share.shareXFiles([XFile(tempPath)],
          text: 'motivational quotes');
      _isLoadingShare.value = false;
      if (result.status == ShareResultStatus.success) {
        _isModified.value = false;
        _isLoadingShare.value = false;
        update();
      }
      if (result.status == ShareResultStatus.dismissed) {
        _isModified.value = false;
        _isLoadingShare.value = false;
        update();
      }
    } catch (e) {
      print('Error sharing image: $e');
      _isLoadingShare.value = false;
      _isModified.value = false;
      update();
    }
  }

  List<FavouriteListModel> favouriteList = [
    FavouriteListModel(
        backgroundId: "1",
        backgroundImage: "assets/images/categories/happiness.png",
        fontFamilyId: "1",
        fontFamily: "Caveat",
        fontColorId: "1",
        fontColor: 0xffF4A261,
        quoteId: "1",
        quote: "God Is Love",
        isSelected: true),
    FavouriteListModel(
        backgroundId: "2",
        backgroundImage: "assets/images/categories/productivity.png",
        fontFamilyId: "2",
        fontFamily: "JosefinSans",
        fontColorId: "2",
        fontColor: 0xff94D2BD,
        quoteId: "2",
        quote: "The way to success is smartwork",
        isSelected: true),
  ];
}

class FavouriteListModel {
  String backgroundId;
  String backgroundImage;
  String fontFamilyId;
  String fontFamily;
  String fontColorId;
  int fontColor;
  String quoteId;
  String quote;
  bool isSelected;

  FavouriteListModel(
      {required this.backgroundId,
      required this.backgroundImage,
      required this.fontFamilyId,
      required this.fontFamily,
      required this.fontColorId,
      required this.fontColor,
      required this.quoteId,
      required this.quote,
      this.isSelected = true});
}
