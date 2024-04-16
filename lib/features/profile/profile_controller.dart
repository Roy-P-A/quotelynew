import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../config/app/app_config.dart';
import '../../managers/sharedpreferences.dart';
import '../../models/basic_settings_category/basic_list_model.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_alertbox.dart';
import 'widgets/basic_settings_list.dart';
import 'widgets/need_help_bottomsheet.dart';
import 'widgets/webview_widget.dart';

class ProfileController extends GetxController {
  final scrollController1 = ScrollController();
  final scrollController2 = ScrollController();
  final scrollController3 = ScrollController();

  final _firstname = "".obs;
  String get firstname => _firstname.value;

  final _lastname = "".obs;
  String get lastname => _lastname.value;

  final _email = "".obs;
  String get email => _email.value;

  final _apikey = "".obs;
  String get apikey => _apikey.value;

  final _paymentEndDate = "".obs;
  String get paymentEndDate => _paymentEndDate.value;

  final _isPaid = false.obs;
  bool get isPaid => _isPaid.value;

  final _isBannerChecker1 = 0.obs;
  int get isBannerChecker1 => _isBannerChecker1.value;

  final _generalSettings =
      List<BasicSettingsListModel>.empty(growable: true).obs;
  List<BasicSettingsListModel> get generalSettings => _generalSettings;

  late OverlayEntry _overlayEntry;

  RxBool isAdLoaded = false.obs;
  //InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;

  @override
  void onInit() async {
    await initFunction();

    super.onInit();
  }

  initFunction() async {
    _generalSettings.value = BasicSettingsList().settingsList;
    //createInterstitialAd();
    createRewardedAd();
    await fetchingUserCredentials();
    _isBannerChecker1.value = await bannerChecker();
    await listRemover();

    debugPrint(isBannerChecker1.toString());
  }

  //   void createInterstitialAd() {
  //   InterstitialAd.load(
  //     adUnitId: 'ca-app-pub-3940256099942544/1033173712',
  //     request: const AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         debugPrint('$ad loaded.');

  //         interstitialAd = ad;
  //       },
  //       onAdFailedToLoad: (error) {
  //         debugPrint('InterstitialAd failed to load: $error');
  //       },
  //     ),
  //   );
  // }

  // void showInterstitialAd(String routeLink) async {
  //   if (interstitialAd != null) {
  //     interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //       onAdShowedFullScreenContent: (ad) {
  //         debugPrint('$ad onAdShowedFullScreenContent.');
  //         //throw Exception("Condition is satisfied, disrupting flow.");
  //       },
  //       onAdDismissedFullScreenContent: (ad) {
  //         debugPrint('$ad onAdDismissedFullScreenContent.');
  //         debugPrint('manu');
  //         ad.dispose();
  //         createInterstitialAd();
  //         Get.toNamed(routeLink);
  //         debugPrint('manu1');

  //         return;
  //       },
  //       onAdFailedToShowFullScreenContent: (ad, error) {
  //         debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
  //         ad.dispose();
  //         createInterstitialAd();
  //       },
  //       onAdImpression: (ad) => debugPrint('$ad impression occurred.'),
  //     );
  //     interstitialAd!.show();
  //   } else {
  //     debugPrint('Interstitial ad not yet loaded.');
  //   }
  // }

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

  void showRewardedAd(String routeLink, String routeLink1) async {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          debugPrint('$ad onAdShowedFullScreenContent.');
        },
        onAdDismissedFullScreenContent: (ad) {
          debugPrint('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
          createRewardedAd();
          routeLink;
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
          Get.toNamed(routeLink);
        },
      );
    } else {
      debugPrint('Rewarded ad not yet loaded.');
    }
  }

  fetchingUserCredentials() async {
    final qtSharedPreferences = QTSharedPreferences();
    _firstname.value = await qtSharedPreferences.getFirstNameFromPrefs() ?? "";
    _lastname.value = await qtSharedPreferences.getLastNameFromPrefs() ?? "";
    _email.value = await qtSharedPreferences.getEmailFromPrefs() ?? "";
    _apikey.value = await qtSharedPreferences.getApiKeyFromPrefs() ?? "";
    _paymentEndDate.value =
        await qtSharedPreferences.getPaymentEndDateFromPrefs() ?? "";

    _isPaid.value = paymentChecker(paymentEndDate);
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

  listRemover() async {
    if (isBannerChecker1 == 2) {
      _generalSettings.value.removeAt(0);
      update();
    }
  }

  @override
  void onClose() {
    scrollController1.dispose();
    scrollController2.dispose();
    scrollController3.dispose();
    rewardedAd?.dispose();
    super.onClose();
  }

  needHelpBottomSheetFunction() async {
    NeedHelpBottomSheet().needHelpBottomSheet(
      Get.context!,
    );
  }

  basicSettingsRouting(BuildContext context, String routeLink) async {
    if (isBannerChecker1 == 2) {
      Get.toNamed(routeLink);
    } else if (isBannerChecker1 == 1) {
      loadAdd(routeLink);
    } else {
      showPopup(context);
    }
  }

  loadAdd(String routeLink) async {
    // createInterstitialAd();
    // showInterstitialAd(routeLink);
    createRewardedAd();
    showRewardedAd(routeLink, routeLink);
  }

  supportSettingsRouting(String routeLink) async {
    if (routeLink == "/privacy") {
      Get.to(const WebViewPage(
          websiteAddress: "https://sites.google.com/view/quotely/home"));
    } else if (routeLink == "/termsandconditions") {
      Get.to(const WebViewPage(
          websiteAddress:
              "https://sites.google.com/view/quotely-termsandconditions/home"));
    } else if (routeLink == "/needhelp") {
      await needHelpBottomSheetFunction();
    } else {}
  }

  profileGuestTap() async {
    await clearSharedPreferences();
    Get.offAllNamed("/signin");
  }

  logout(BuildContext context) async {
    showPopup1(context);
  }

  void showPopup1(BuildContext context) {
    _overlayEntry = CustomOverlay.createOverlayEntry(context,
        yesCallback: () => yesandhidePopup(),
        closeCallback: () => hidePopup(),
        color: 0xffFF7676,
        text: 'Are you sure you want to logout',
        firstButtontext: "Logout",
        height: 270);
    Overlay.of(context).insert(_overlayEntry);
    update();
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
    await signouts();
    Get.offAllNamed("/signin");
    update();
  }

  signouts() async {
    await signOutFromFacebook();
    await signOutFromGoogle();
  }

  signOutFromFacebook() async {
    try {
      await FacebookAuth.instance.logOut();
      debugPrint('Successfully signed out from Facebook');
    } catch (e) {
      debugPrint('Facebook sign out error: $e');
    }
  }

  signOutFromGoogle() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      debugPrint('Successfully signed out from Google');
    } catch (e) {
      debugPrint('Google sign out error: $e');
    }
  }
}
