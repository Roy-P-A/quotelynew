import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/app/app_config.dart';
import '../../dtos/api_dtos/login/login.dart';
import '../../managers/sharedpreferences.dart';
import '../../mixins/snackbar_mixin.dart';
import '../../models/signin/login_model.dart';
import '../../repository/repository.dart';
import '../../utils/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   if (result == ConnectivityResult.none) {
    //     isConnected.value = false;
    //   } else {
    //     isConnected.value = true;
    //   }
    // });
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

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

// finally, lets ssign in
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      debugPrint("email: ${user!.email}");
      debugPrint("dissplayName: ${user!.displayName}");
      debugPrint("emailverified: ${user!.emailVerified}");
      debugPrint("phonenumber: ${user.phoneNumber}");
      debugPrint("photourl: ${user.photoURL}");
      debugPrint("refreshtoken: ${user.refreshToken}");
    } on FirebaseAuthException catch (error) {
      debugPrint("Google Sign-In error: ${error.message}");
    }
  }

// signInWithGoogle() async {
//   try {
//     // Begin interactive sign-in process
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//     if (gUser == null) {
//       // User canceled the sign-in process
//       return;
//     }

//     // Obtain auth details from request
//     final GoogleSignInAuthentication gAuth = await gUser.authentication;

//     // Create a new credential for user
//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );

//     // Finally, sign in
//     final UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);

//         debugPrint(userCredential!.user!.email.toString());
//     final User? user = userCredential.user;
//         debugPrint(user.toString());

//     if (user != null) {
//       // Print user info
//       debugPrint("email: ${user.email}");
//       debugPrint("display name: ${user.displayName}");
//       debugPrint("email verified: ${user.emailVerified}");
//       debugPrint("phone number: ${user.phoneNumber}");
//       debugPrint("photo URL: ${user.photoURL}");
//       debugPrint("refresh token: ${user.refreshToken}");
//     } else {
//       debugPrint("User is null after signing in with Google.");
//     }
//   } on FirebaseAuthException catch (error) {
//     debugPrint("Firebase authentication error: ${error.message}");
//   } catch (error) {
//     debugPrint("Unexpected error during Google Sign-In: $error");
//   }
// }

  // signInWithGoogle() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   //     clientId:
  //   //         "258869472088-drooevp8e6sts8tf7jkh3k41sotr5tgt.apps.googleusercontent.com");
  //   final GoogleSignIn _googleSignIn = GoogleSignIn(
  //       clientId:
  //           "258869472088-drooevp8e6sts8tf7jkh3k41sotr5tgt.apps.googleusercontent.com");
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  //     debugPrint(googleUser.toString());

  //     if (googleUser == null) {
  //       // User canceled the sign-in process
  //       return;
  //     }

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     debugPrint(googleAuth.idToken);
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     //await _auth.signInWithCredential(credential);
  //     debugPrint("toor");
  //     final UserCredential userCredential = await _auth.signInWithCredential(credential);
  //     debugPrint(userCredential.toString());
  //     final User? user = userCredential.user;

  //     if (user != null) {
  //       // User signed in successfully
  //       // Perform any additional actions (e.g., navigate to home screen)
  //       debugPrint("tumb");
  //         showErrorSnackbar(
  //         title: "Success", message: "Please successon");
  //     await Future.delayed(const Duration(seconds: 2));
  //     }
  //   } catch (error) {
  //     debugPrint("tim");
  //       showErrorSnackbar(
  //         title: "Fail", message: "Fail");
  //     await Future.delayed(const Duration(seconds: 2));
  //   }
  // }
// Future<void> signInWithGoogle() async {
//   try {
//     // Sign in with Google
//     final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//     if (googleSignInAccount == null) return; // User cancelled sign-in

//     // Get authentication details
//     final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount.authentication;

//     // Create Firebase credential
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleSignInAuthentication.accessToken,
//       idToken: googleSignInAuthentication.idToken,
//     );

//     // Sign in with Firebase
//     final UserCredential userCredential = await _auth.signInWithProvider(GoogleAuthProvider());

//     // Get the signed-in user
//     // final User? user = userCredential.user;

//     // if (user != null) {
//     //   debugPrint("User signed in successfully!");
//     //   showErrorSnackbar(title: "Success", message: "Signed in successfully!");
//     //   // Perform additional actions based on the signed-in user (e.g., navigate to a user profile screen)
//     // }
//   } on FirebaseAuthException catch (e) {
//     debugPrint(e.message);
//     String message = "An error occurred during sign-in";
//     switch (e.code) {
//       case "account-exists-with-different-credential":
//         message = "The email address is already in use with a different account.";
//         break;
//       case "invalid-credential":
//         message = "The provided credential is invalid.";
//         break;
//       // Handle other common error codes (refer to Firebase documentation)
//       default:
//         break;
//     }
//     showErrorSnackbar(title: "Error", message: message);
//     throw e; // Re-throw for further handling if needed
//   }
// }

//   signInWithGoogle() async {
//     GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
// GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

// FirebaseUser user = await auth.signInWithGoogle(
//     idToken: gSA.idToken, accessToken: gSA.accessToken);

//   }

// signInWithGoogle() async {
//   try{
//     GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
//    final  manu  = await FirebaseAuth.instance.signInWithProvider(_googleAuthProvider) as int;
//    debugPrint(manu.toString());

//   }catch(error){
//     debugPrint("Fail");
//     debugPrint(error.toString());
//   }

// }

// Future<void> signInWithGoogle() async {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final GoogleSignInAccount? account = await googleSignIn.signIn();

//   if (account != null) {
//     final GoogleSignInAuthentication authentication = await account.authentication;
//     final String? idToken = authentication.idToken;

//     // Process the ID token or other user data (example with potential type mismatch)
//     final GoogleSignInProfile? userProfile = await googleSignIn.getUserProfile();
//     List<dynamic>? userData = userProfile?.data;  // Handle potential null userProfile

//     if (userData != null) {
//       try {
//         List<int?> integerList = userData.whereType<int>().toList();
//         int? specificValue = userData['fieldName'] as int?; // Access specific field

//         // Use the data after type checks
//         print(integerList);
//         print(specificValue);
//       } on CastError catch (e) {
//         print('Error casting data: $e');
//         // Handle the error appropriately, e.g., display an error message or use default values
//       }
//     }
//   } else {
//     print('Sign-in cancelled');
//   }
// }

  //-----------
}
