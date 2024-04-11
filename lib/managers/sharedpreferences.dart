import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class QTSharedPreferences {
  Future<void> saveTokensToPrefs(
      String userid,
      String firstName,
      String lastName,
      String email,
      String role,
      String apikey,
      String paymentEndDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userid);
    await prefs.setString('first_name', firstName);
    await prefs.setString('last_name', lastName);
    await prefs.setString('email', email);
    await prefs.setString('role', role);
    await prefs.setString('apikey', apikey);
    await prefs.setString('payment_end_date', paymentEndDate);
    debugPrint('Tokens saved to SharedPreferences');
  }

  Future<String?> getUserIdFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id') ?? null;
  }

  Future<String?> getFirstNameFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('first_name') ?? null;
  }

  Future<String?> getLastNameFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_name') ?? null;
  }

  Future<String?> getEmailFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? null;
  }

  Future<String?> getRoleFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? null;
  }

  Future<String?> getApiKeyFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('apikey') ?? null;
  }

  Future<String?> getPaymentEndDateFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('payment_end_date') ?? null;
  }

  Future<String?> getBackgroundSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('backgroundsettings') ?? null;
  }

  Future<void> savebackgroundSettings1(
    String jsonData1,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('backgroundsettings', jsonData1);
    debugPrint('Tokens saved to SharedPreferences');
  }
}

// //logout
clearSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_id');
  await prefs.remove('first_name');
  await prefs.remove('last_name');
  await prefs.remove('email');
  await prefs.remove('role');
  await prefs.remove('apikey');
  await prefs.remove('payment_end_date');
  await prefs.remove('backgroundsettings');
  debugPrint('SharedPreferences cleared.');
}

// class JBJWTDecoder {
//   Future<Map<String, dynamic>?> decodeAuthToken() async {
//     await RefreshTokenExpiryChecker().refreshTokenExpiryChecker();
//     await RefreshTokenApiCall().checkTokenExpiration();
//     final authToken = await JBSharedPreferences().getTokenFromPrefs();
//     if (authToken != null) {
//       return JwtDecoder.decode(authToken);
//     }
//     return null;
//   }
// }