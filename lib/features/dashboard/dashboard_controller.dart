import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../config/app/app_config.dart';
import '../../dtos/api_dtos/dashboard_screen/backgroundsettingsuser/backgroundsettingsuser.dart';
import '../../dtos/api_dtos/dashboard_screen/quotes_fetching/quotes_fetching.dart';
import '../../managers/sharedpreferences.dart';
import '../../mixins/snackbar_mixin.dart';
import '../../models/dashboard/backgroundsettingsuser/backgroundsetingsuser_model.dart';
import '../../models/dashboard/quote_fetching/quote_fetching_model.dart';
import '../../models/dashboard/quote_list_model.dart';
import '../../repository/repository.dart';
import '../../widgets/custom_alertbox.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

import 'sections/quote_section/quote_list.dart';

class DashboardController extends GetxController with SnackbarMixin {
  final GlobalKey _key = GlobalKey();
  final PageController pageController = PageController(initialPage: 0);

  GlobalKey get key => _key;

  var isExpanded = false.obs;

  var isHeartIconChanged = false.obs;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isLoadingQuotes = false.obs;
  bool get isLoadingQuotes => _isLoadingQuotes.value;

  final _isPageroute1 = "".obs;
  String get isPageroute1 => _isPageroute1.value;

  final _pageIndex = 0.obs;
  int get pageIndex => _pageIndex.value;

  final _isLoadingBackgroundSettingsFinished = false.obs;
  bool get isLoadingBackgroundSettingsFinished =>
      _isLoadingBackgroundSettingsFinished.value;

  late OverlayEntry _overlayEntry;

  final _fetchedBackgroundSettings0 = Rx<BackgroundSettingsUserModel?>(null);
  BackgroundSettingsUserModel? get fetchedBackgroundSettings0 =>
      _fetchedBackgroundSettings0.value;

  final _fetchedBackgroundSettings = Rx<BackgroundSettingsUserModel?>(null);
  BackgroundSettingsUserModel? get fetchedBackgroundSettings =>
      _fetchedBackgroundSettings.value;

  final _quoteList = (List<QuoteListModel>.empty()).obs;
  List<QuoteListModel> get quotelist => _quoteList;

  final _quoteList1 = Rx<QuoteFetchingModel?>(null);
  QuoteFetchingModel? get quoteList1 => _quoteList1.value;

  final _quoteList2 = (List<QuoteListModel1>.empty()).obs;
  List<QuoteListModel1> get quotelist2 => _quoteList2;

  final _quoteListInStringFormat = "".obs;
  String get quoteListInStringFormat => _quoteListInStringFormat.value;

  final _quoteList3 = (List<QuoteListModel1>.empty()).obs;
  List<QuoteListModel1> get quoteList3 => _quoteList3;

  final Set<QuoteListModel1> _readedquoteList3 = <QuoteListModel1>{}.obs;
  Set<QuoteListModel1> get readedquoteList3 => _readedquoteList3;

  final _readedquoteListSending = (List<int>.empty()).obs;
  List<int> get readedquoteListSending => _readedquoteListSending;

  final _totalPages = 0.obs;
  int get totalPages => _totalPages.value;

  final _currentPage = "".obs;
  String get currentPage => _currentPage.value;

  final qtSharedPreferences = QTSharedPreferences();

  // ---ad related----start
  RxBool isAdLoaded = false.obs;
  // InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;

  // ---ad related----end

  final _user_id = "".obs;
  String get user_id => _user_id.value;

  final _apikey = "".obs;
  String get apikey => _apikey.value;

  final _paymentEndDate = "".obs;
  String get paymentEndDate => _paymentEndDate.value;

  final _isPaid = false.obs;
  bool get isPaid => _isPaid.value;

  final _isBannerChecker1 = 0.obs;
  int get isBannerChecker1 => _isBannerChecker1.value;

  final _isModified = false.obs;
  bool get isModified => _isModified.value;

  final _isLoadingShare = false.obs;
  bool get isLoadingShare => _isLoadingShare.value;

  @override
  void onInit() async {
    await initFunction();
    super.onInit();
  }

  initFunction() async {
    await fetchingUserCredentials();
    await getGlobalSettingsUser();
    await getQuoteListFromSavedApi();
    await quotesApiCall();

    createRewardedAd();
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    // interstitialAd?.dispose();
    rewardedAd?.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    rewardedAd?.dispose();
    super.dispose();
  }

  indexNotifying(index) async {
    _pageIndex.value = index;

    if (!_readedquoteList3.contains(quoteList3[index])) {
      _readedquoteList3.add(quoteList3[index]);
    }

    debugPrint("chin${readedquoteList3}");

    if (readedquoteList3.length > 20) {
      _readedquoteListSending.clear();
      List<QuoteListModel1> tempList = readedquoteList3.toList();
      _readedquoteList3.clear();
      for (int i = 0; i < tempList.length; i++) {
        _readedquoteListSending.value.add(int.parse(tempList[i].id));
      }
      debugPrint("tipper${readedquoteListSending}");
      await quotesApiCall();
      await getQuoteListFromSavedApi();
    }
  }

  fetchingUserCredentials() async {
    final qtSharedPreferences = QTSharedPreferences();
    _user_id.value = await qtSharedPreferences.getUserIdFromPrefs() ?? "";
    _apikey.value = await qtSharedPreferences.getApiKeyFromPrefs() ?? "";
    _paymentEndDate.value =
        await qtSharedPreferences.getPaymentEndDateFromPrefs() ?? "";
    _isPaid.value = paymentChecker(paymentEndDate);
    _isBannerChecker1.value = await bannerChecker();
  }

  bannerChecker() {
    if (isPaid) {
      update();
      return 2;
    } else if (apikey != QTAppConfigManager.config.defaultapikey) {
      update();
      return 1;
    } else {
      update();
      return 0;
    }
  }

  bool paymentChecker(String epochTimeInSeconds) {
    if (epochTimeInSeconds == "") {
      return false;
    }
    int epochTimeInSeconds1 = int.parse(epochTimeInSeconds);
    DateTime dateTimeFromEpoch =
        DateTime.fromMillisecondsSinceEpoch(epochTimeInSeconds1 * 1000);
    DateTime currentDateTime = DateTime.now();
    return dateTimeFromEpoch.isAfter(currentDateTime);
  }

  beforeButton(BuildContext context, VoidCallback func1) async {
    if (isBannerChecker1 == 2) {
      return;
    } else if (isBannerChecker1 == 1) {
      await loadAdd(func1);
      throw Exception("Condition is satisfied, disrupting flow.");
    } else {
      showPopup(context);
      throw Exception("Condition is satisfied, disrupting flow.");
    }
  }

  //---ad related---start

  void createRewardedAd() {
    RewardedAd.load(
      adUnitId: QTAppConfigManager.config.rewardedAdId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  void showRewardedAd(VoidCallback func1, VoidCallback func2) async {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          debugPrint('$ad onAdShowedFullScreenContent.');
        },
        onAdDismissedFullScreenContent: (ad) {
          debugPrint('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
          createRewardedAd();
          func1();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          createRewardedAd();
        },
        onAdImpression: (ad) => debugPrint('$ad impression occurred.'),
      );
      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          func2();
        },
      );
    } else {
      debugPrint('Rewarded ad not yet loaded.');
    }
  }

  //--ad related---end

  getGlobalSettingsUser() async {
    await getGlobalSettingsUserPreferences();
    await getGlobalSettingsUserApiCall();
  }

  getGlobalSettingsUserPreferences() async {
    if (await qtSharedPreferences.getBackgroundSettings() != null) {
      String? jsonString2 = await qtSharedPreferences.getBackgroundSettings();

      if (jsonString2 != null) {
        _fetchedBackgroundSettings.value =
            BackgroundSettingsUserModel.fromJson(json.decode(jsonString2));
        _isLoadingBackgroundSettingsFinished.value = true;
        debugPrint(fetchedBackgroundSettings.toString());
        update();
      }
    }
  }

  getGlobalSettingsUserApiCall() async {
    _isLoadingBackgroundSettingsFinished.value = false;
    final apikey1 = apikey;
    final userId = user_id;
    try {
      final request =
          BackgroundSettingsUserRequest(apikey: apikey1, userId: userId);
      final response =
          await ApiRepository.to.getBackgroundSettingsUser(request: request);
      if (response.status == 200) {
        _fetchedBackgroundSettings0.value = response.data;
        await savingBackgroundSettingsData();
        _isLoadingBackgroundSettingsFinished.value = true;
        update();
      } else {
        _isLoadingBackgroundSettingsFinished.value = true;
      }
    } catch (e) {
      showErrorSnackbar(title: "Error", message: e.toString());
      debugPrint(e.toString());

      _isLoadingBackgroundSettingsFinished.value = true;
    }
  }

  savingBackgroundSettingsData() async {
    if ((fetchedBackgroundSettings0 != null)) {
      String jsonString = json.encode(fetchedBackgroundSettings0!.toJson());
      await qtSharedPreferences.savebackgroundSettings1(jsonString);
      await getGlobalSettingsUserPreferences();
      update();
    } else {}
  }

  void toggleExpandedOpen() {
    isExpanded.value = true;
  }

  void toggleExpandedClose() {
    isExpanded.value = false;
  }

  void shareButton(BuildContext context) async {
    _isModified.value = true;
    await beforeButton(context, shareImageToSocialMedia);
    shareImageToSocialMedia();
  }

  manu() {
    //Get.offAllNamed('/signin');
    debugPrint("ticktok1234");
  }

  shareImageToSocialMedia() async {
    _isLoadingShare.value = true;
    await Future.delayed(const Duration(seconds: 1));
    final RenderRepaintBoundary boundary =
        _key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    // img.Image imgImage = img.decodeImage(pngBytes)!;

    // // Resize the image to reduce its size
    // img.Image resizedImage = img.copyResize(imgImage, width: 800);

    // // Compress the image to reduce file size
    // Uint8List compressedBytes = img.encodeJpg(resizedImage, quality: 100);

    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/screenshot.png';
    File(tempPath).writeAsBytesSync(pngBytes);
    //File(tempPath).writeAsBytesSync(img.encodePng(imgImage));
    //File(tempPath).writeAsBytesSync(compressedBytes);
    try {
      final result = await Share.shareXFiles([XFile(tempPath)],
          text: 'motivational quotes');
      _isLoadingShare.value = false;
      if (result.status == ShareResultStatus.success) {
        _isModified.value = false;
        update();
      }
      if (result.status == ShareResultStatus.dismissed) {
        _isModified.value = false;
        update();
      }
    } catch (e) {
      print('Error sharing image: $e');
      _isLoadingShare.value = false;
      _isModified.value = false;
      update();
    }
  }

  customButton1Function(BuildContext context, String pageRoute) async {
    _isPageroute1.value = pageRoute;
    await beforeButton(context, customButton1routingFunction);
    Get.toNamed(pageRoute);
  }

  customButton1routingFunction() {
    Get.toNamed(isPageroute1);
  }

  loadAdd(VoidCallback func1) async {
    createRewardedAd();
    showRewardedAd(func1, func1);
  }

  heartToggleExpanded() {
    //debugPrint(quoteList3[pageIndex].isFavourite.toString());
    if (quoteList3[pageIndex].isFavourite == true) {
      debugPrint("before${quoteList3[pageIndex].isFavourite.toString()}");
      _quoteList3[pageIndex].isFavourite = false;
      debugPrint("after${quoteList3[pageIndex].isFavourite.toString()}");
      update();
    } else {
      debugPrint("before2${quoteList3[pageIndex].isFavourite.toString()}");
      _quoteList3[pageIndex].isFavourite = true;
      debugPrint("after2${quoteList3[pageIndex].isFavourite.toString()}");
      update();
    }
  }

  saveQuotesApiCall() async {
    if ((quotelist2.isNotEmpty)) {
      String jsonString =
          json.encode(quotelist2.map((quote) => quote.toJson()).toList());

      await qtSharedPreferences.savequotesList(jsonString);
      _quoteListInStringFormat.value =
          await qtSharedPreferences.getQuoteList() ?? "";
      if (quoteListInStringFormat != "") {
        List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(
            json.decode(quoteListInStringFormat));

        List<QuoteListModel1> quoteList = jsonList
            .map((jsonMap) => QuoteListModel1.fromJson(jsonMap))
            .toList();
        _quoteList3.value = quoteList;
      }

      update();
    } else {}
  }

  getQuoteListFromSavedApi() async {
    _quoteListInStringFormat.value =
        await qtSharedPreferences.getQuoteList() ?? "";
    if (quoteListInStringFormat != "") {
      List<Map<String, dynamic>> jsonList =
          List<Map<String, dynamic>>.from(json.decode(quoteListInStringFormat));

      List<QuoteListModel1> quoteList =
          jsonList.map((jsonMap) => QuoteListModel1.fromJson(jsonMap)).toList();
      _quoteList3.value = quoteList;
    }
  }

  quotesApiCall() async {
    _isLoading.value = true;
    try {
      final request = QuotesFetchingRequest(
        pageNo: 0,
        pageSize: 5,
        orderBy: 'ASC',
        sortBy: 'id',
        apikey: apikey,
        userid: user_id,
        readedList: readedquoteListSending,
      );
      final response = await ApiRepository.to.quotesFetching(request: request);
      if (response.status == 200) {
        _quoteList1.value = response.data;
        if (quoteList1 != null) {
          for (int i = 0; i < quoteList1!.content.length; i++) {
            _quoteList2.add(
              QuoteListModel1(
                  id: quoteList1!.content[i].quotesId,
                  quote: quoteList1!.content[i].quoteDescription,
                  isFavourite: false),
            );
          }
          await saveQuotesApiCall();
        }
      } else {
        _isLoading.value = false;
      }
    } catch (e) {
      showErrorSnackbar(title: "Error", message: e.toString());
      debugPrint(e.toString());
      _isLoading.value = false;
    }
  }

  void showPopup(BuildContext context) {
    _overlayEntry = CustomOverlay.createOverlayEntry(context,
        yesCallback: () => yesandhidePopup(),
        closeCallback: () => hidePopup(),
        color: 0xff744EFD,
        text: 'You need to signin',
        firstButtontext: "Proceed",
        height: 250);
    Overlay.of(context).insert(_overlayEntry);
    update();
  }

  void hidePopup() {
    _overlayEntry.remove();
    update();
  }

  void yesandhidePopup() async {
    _overlayEntry.remove();
    await clearSharedPreferences();
    Get.offAllNamed("/signin");
    update();
  }
}
