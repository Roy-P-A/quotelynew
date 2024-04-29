import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../flavors.dart';

@immutable
class QTAppConfig {
  final String backendBaseURL;
  final String serviceUrl;
  final String httpScheme;

  //default section
  final String defaultfirstName;
  final String defaultlastName;
  final String defaultemail;
  final String defaultrole;
  final String defaultapikey;
  final String defaultpaymentEndDate;
  final String defaultuserId;
  //Firebaseoptions
  final String fireBaseApiKey;
  final String firebaseappId;
  final String firebasemessagingSenderId;
  final String firebaseprojectId;

  //RewardedAd
  final bool rewardedAdLiveMode;
  final String rewardedAdId;

  //default section1
  final int defaultbackgroundimageId;
  final int defaultfontfamilyId;
  final int defaultfontColorId;

  const QTAppConfig(
      {required this.backendBaseURL,
      required this.serviceUrl,
      required this.httpScheme,
      //firebaseoptions
      required this.fireBaseApiKey,
      required this.firebaseappId,
      required this.firebasemessagingSenderId,
      required this.firebaseprojectId,

      //RewardedAd
      required this.rewardedAdLiveMode,
      required this.rewardedAdId,

      //default section
      required this.defaultfirstName,
      required this.defaultlastName,
      required this.defaultemail,
      required this.defaultrole,
      required this.defaultapikey,
      required this.defaultpaymentEndDate,
      required this.defaultuserId,
      //default section1
      required this.defaultbackgroundimageId,
      required this.defaultfontfamilyId,
      required this.defaultfontColorId});
}

class QTAppConfigManager {
  static QTAppConfig _getDevConfig() {
    return QTAppConfig(
        backendBaseURL: "192.168.29.159:4321",
        serviceUrl: "quotely-service",
        httpScheme: "http",
        //firebaseoptions
        fireBaseApiKey: Platform.isIOS
            ? "AIzaSyBoLrgx8dttwP1wxXZFXzbtaMJnj8iFyF8"
            : "AIzaSyD4KVafXdlBUqDeBeJ7ZBZMohtXnIutgTc",
        firebaseappId: Platform.isIOS
            ? "1:258869472088:ios:2786e4c5678e0c9cc1d32d"
            : "1:258869472088:android:c7601f922d1128c5c1d32d",
        firebasemessagingSenderId:
            Platform.isIOS ? "258869472088" : "258869472088",
        firebaseprojectId: Platform.isIOS ? "quotely-7f787" : "quotely-7f787",

        //RewardedAd
        rewardedAdLiveMode: false,
        rewardedAdId: false
            ? "ca-app-pub-9827595854898202/4220959147"
            : "ca-app-pub-3940256099942544/5224354917",

        //default section
        defaultuserId: "1",
        defaultfirstName: "Default",
        defaultlastName: "user",
        defaultemail: "roypamechbc@gmail.com",
        defaultrole: "USER",
        defaultapikey: "2a6d09f3d0964f6589f01277682c3890",
        defaultpaymentEndDate: "",
        //default section1
        defaultbackgroundimageId: 9,
        defaultfontfamilyId: 1,
        defaultfontColorId: 1
        
        );
  }

  static QTAppConfig _getProdConfig() {
    return QTAppConfig(
        backendBaseURL: "13.200.132.41:4321",
        serviceUrl: "quotely-service",
        httpScheme: "http",
        //firebaseoptions
        fireBaseApiKey: Platform.isIOS
            ? "AIzaSyBoLrgx8dttwP1wxXZFXzbtaMJnj8iFyF8"
            : "AIzaSyD4KVafXdlBUqDeBeJ7ZBZMohtXnIutgTc",
        firebaseappId: Platform.isIOS
            ? "1:258869472088:ios:2786e4c5678e0c9cc1d32d"
            : "1:258869472088:android:c7601f922d1128c5c1d32d",
        firebasemessagingSenderId:
            Platform.isIOS ? "258869472088" : "258869472088",
        firebaseprojectId: Platform.isIOS ? "quotely-7f787" : "quotely-7f787",

        //RewardedAd
        rewardedAdLiveMode: false,
        rewardedAdId: false
            ? "ca-app-pub-9827595854898202/4220959147"
            : "ca-app-pub-3940256099942544/5224354917",

        //default section
        defaultuserId: "1",
        defaultfirstName: "Default",
        defaultlastName: "user",
        defaultemail: "roypamechbc@gmail.com",
        defaultrole: "USER",
        defaultapikey: "2a6d09f3d0964f6589f01277682c3890",
        defaultpaymentEndDate: "",
        //default section1
        defaultbackgroundimageId: 9,
        defaultfontfamilyId: 1,
        defaultfontColorId: 1
        
        );
  }

  static final QTAppConfig _instance = _getConfig();
  static QTAppConfig _getConfig() {
    QTAppConfig config;
    switch (F.appFlavor) {
      case Flavor.dev:
        config = _getDevConfig();
        break;
      case Flavor.prod:
        config = _getProdConfig();
        break;
      default:
        config = _getDevConfig();
        break;
    }
    return config;
  }

  static QTAppConfig get config => _instance;
}
