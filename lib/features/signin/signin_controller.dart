import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../config/app/app_config.dart';
import '../../dtos/api_dtos/login/login.dart';
import '../../managers/sharedpreferences.dart';
import '../../mixins/snackbar_mixin.dart';
import '../../models/signin/login_model.dart';
import '../../repository/repository.dart';
import '../../utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignInController extends GetxController with SnackbarMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  final _validationDisplay = false.obs;
  bool get validationDisplay => _validationDisplay.value;
  final _obsecureText = true.obs;
  bool get obsecureText => _obsecureText.value;
  var isChecked = false.obs;
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _loginResponse = Rx<LoginModel?>(null);
  LoginModel? get loginResponse => _loginResponse.value;

  var isConnected = false.obs;

  @override
  void onInit() async {
    checkInternetConnection();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected.value = false;
      } else {
        isConnected.value = true;
      }
    });
    await loadUserDataFromSharedPreferences();
    super.onInit();
  }

  void checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected.value = false;
    } else {
      isConnected.value = true;
    }
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return "Email-id is required";
    } else if (!isValidEmail(emailController.value.text)) {
      return "Invalid email";
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return "Password is required";
    } else if (value.length < 8) {
      return "Minimum 8 characters is required";
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "At least one uppercase letter is required";
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "At least one lowercase letter is required";
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "At least one number is required";
    } else if (!RegExp(r'[!@#$%^&*()_+{}\[\]:;<>,.?/\\|-]').hasMatch(value)) {
      return "At least one special character is required";
    }
    return null;
  }

  convertToVisible() {
    _obsecureText.value = false;
    update();
  }

  convertToInvisible() {
    _obsecureText.value = true;
    update();
  }

  void toggleCheckbox() {
    isChecked.toggle();
  }

  Future<void> loadUserDataFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email2') ?? '';
    final savedPassword = prefs.getString('password2') ?? '';
    emailController.value.text = savedEmail;
    passwordController.value.text = savedPassword;
  }

  _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isChecked.value) {
      await prefs.setString('email2', emailController.value.text);
      await prefs.setString('password2', passwordController.value.text);
    } else {
      await prefs.remove('email2');
      await prefs.remove('password2');
    }
  }

  login() {}
  registerWithBody() async {
    debugPrint(emailController.value.text);
    debugPrint(passwordController.value.text);
    _isLoading(true);

    if ((emailValidator(emailController.value.text) == null) &&
        (passwordValidator(passwordController.value.text) == null)) {
    } else {
      _validationDisplay.value = true;
      update();
      return;
    }

    try {
      final request = LoginRequest(
          email: emailController.value.text,
          password: passwordController.value.text,
          role: "USER");
      final response = await ApiRepository.to.login(request: request);

      if (response.status == 200) {
        _loginResponse.value = response.data;
        final qtSharedPreferences = QTSharedPreferences();
        String userid = loginResponse!.userId;
        String firstName = loginResponse!.firstName;
        String lastName = loginResponse!.lastName;
        String email = loginResponse!.email;
        String role = loginResponse!.role;
        String apikey = loginResponse!.apikey;
        String paymentEndDate = loginResponse!.paymentEndDate ?? "";
        debugPrint(userid);
        await qtSharedPreferences.saveTokensToPrefs(
            userid, firstName, lastName, email, role, apikey, paymentEndDate);
        await _saveCredentials();
        await Future.delayed(const Duration(seconds: 2));
        await Get.offAllNamed('/dashboard');
      } else {
        // showErrorSnackbar(title: "Error", message: response.messagecall());
        _isLoading(false);
      }
    } catch (e) {
      _isLoading(false);
      return catchErrorSection(e);
    }
  }

  void catchErrorSection(e) async {
    if (e.toString().isNotEmpty) {
      try {
        Map<String, dynamic> errorResponse = jsonDecode(e.toString());

        if (errorResponse.containsKey("errors")) {
          List<String> errors = List<String>.from(errorResponse["errors"]);

          String errorMessage = errors.join(", ");
          showErrorSnackbar(
            title: "Error",
            message: errorMessage,
          );
        }
      } catch (e) {
        showErrorSnackbar(
          title: "Error",
          message: e.toString(),
        );
        debugPrint('Error decoding JSON: ${e.toString()}');
      }
    }
  }

  signUpAsGuest() async {
    final qtSharedPreferences = QTSharedPreferences();
    String userid = QTAppConfigManager.config.defaultuserId;
    String firstName = QTAppConfigManager.config.defaultfirstName;
    String lastName = QTAppConfigManager.config.defaultlastName;
    String email = QTAppConfigManager.config.defaultemail;
    String role = QTAppConfigManager.config.defaultrole;
    String apikey = QTAppConfigManager.config.defaultapikey;
    String paymentEndDate = QTAppConfigManager.config.defaultpaymentEndDate;

    if (isConnected.value == false) {
      showErrorSnackbar(
          title: "Error", message: "Please check the internet connection");
      await Future.delayed(const Duration(seconds: 2));
      return;
    }
    await qtSharedPreferences.saveTokensToPrefs(
        userid, firstName, lastName, email, role, apikey, paymentEndDate);
    await Future.delayed(const Duration(seconds: 2));

    await Get.offAllNamed('/dashboard');
  }

  //---
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      debugPrint("email: ${user!.email}");
      debugPrint("dissplayName: ${user!.displayName}");
      debugPrint("emailverified: ${user!.emailVerified}");
      debugPrint("phonenumber: ${user.phoneNumber}");
      debugPrint("photourl: ${user.photoURL}");
      debugPrint("refreshtoken: ${user.refreshToken}");
      showSuccessSnackbar(
          title: "Success", message: "You are successfully logined");
      await Future.delayed(const Duration(seconds: 2),(){});
      await signUpAsGuest();    
    } on FirebaseAuthException catch (error) {
      debugPrint("Google Sign-In error: ${error.message}");
      showErrorSnackbar(
          title: "Error", message: "Google Login Failed");
    }
  }


//---
  // signInWithApple() async {
  //   if (await SignInWithApple.isAvailable()) {
  //     final credential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );

  //     debugPrint(credential.toString());

  //     debugPrint('Email: ${credential.email}');
  //     debugPrint('givenName: ${credential.givenName}');
  //     debugPrint('Family Name: ${credential.familyName}');
  //     debugPrint('Authorization Code: ${credential.authorizationCode}');
  //     debugPrint('Identity token: ${credential.identityToken}');
  //   } else {
  //     debugPrint('Sign in with Apple is not available');
  //   }
  // }

   signInWithApple() async {
    try {
      // Perform the Apple sign-in process
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'your_client_id',
          redirectUri: Uri.parse(
            'https://your-redirect-uri.com',
          ),
        ),
      );

      // Handle the returned credential
      debugPrint('User ID: ${credential.userIdentifier}');
      debugPrint('Email: ${credential.email}');
     
      debugPrint('Authorization Code: ${credential.authorizationCode}');
      debugPrint('Identity Token: ${credential.identityToken}');
      debugPrint('State: ${credential.state}');
    } catch (e) {
      // Handle errors
      debugPrint('Error during sign-in with Apple: $e');
     
    }
  }



  signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance
          .login(permissions: const ['email', 'public_profile']);

      if (result.status == LoginStatus.success) {
        debugPrint(result.accessToken.toString());
        final AccessToken accessToken = result.accessToken!;
        debugPrint(accessToken.token);
        debugPrint(accessToken.userId);
        debugPrint('Success');

        final userData = await FacebookAuth.instance.getUserData(
          fields:
              "email, name, picture", // Specify the fields you want to fetch
        );

        // Extract email and public profile from user data
        final String? email = userData['email'];
        final String? name = userData['name'];
        final String? pictureUrl = userData['picture']['data']['url'];

        debugPrint('Email: $email');
        debugPrint('Name: $name');
        debugPrint('Profile Picture URL: $pictureUrl');
        showSuccessSnackbar(
          title: "Success", message: "You are successfully logined");
        await Future.delayed(const Duration(seconds: 2),(){});  
        await signUpAsGuest(); 
      } else {
        debugPrint('Failed');
        showErrorSnackbar(
          title: "Error", message: "Facebook Login Failed");
      }
    } catch (e) {
      // Handle any exceptions that occur during login
      debugPrint('Facebook login error: $e');
      showErrorSnackbar(
          title: "Error", message: "Facebook Login Failed");
    }
  }

  //-----------
}
