import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app/app_config.dart';
import '../../dtos/api_dtos/perssubsection/sendbackgroundsettings/sendbackgroundsettings.dart';
import '../../dtos/api_dtos/signup/signup.dart';
import '../../managers/sharedpreferences.dart';
import '../../mixins/snackbar_mixin.dart';
import '../../models/signup/signup_model.dart';
import '../../repository/repository.dart';
import '../../utils/utils.dart';

class SignUpController extends GetxController with SnackbarMixin {
  var firstnameController = TextEditingController().obs;
  var lastnameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmpasswordController = TextEditingController().obs;

  final _validationDisplay = false.obs;
  bool get validationDisplay => _validationDisplay.value;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _obsecureText1 = true.obs;
  bool get obsecureText1 => _obsecureText1.value;

  final _obsecureText2 = true.obs;
  bool get obsecureText2 => _obsecureText2.value;

  final _signUpResponse = Rx<SignUpModel?>(null);
  SignUpModel? get signUpResponse => _signUpResponse.value;

  String? firstNameValidator(String value) {
    if (value.isEmpty) {
      return "First name is required";
    } else if (value.length < 2) {
      return "Minimum two characters required";
    } else if (value.length > 15) {
      return "Maximum character is 15";
    }
    return null;
  }

  String? lastNameValidator(String value) {
    if (value.isEmpty) {
      return "Last name is required";
    }
    return null;
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

  String? confirmpasswordValidator(String value) {
    if (value.isEmpty) {
      return "Confirm password is required";
    }
    if (passwordController.value.text != value) {
      return "Password do not match";
    }
    return null;
  }

  convertToVisible1() {
    _obsecureText1.value = false;
    update();
  }

  convertToVisible2() {
    _obsecureText2.value = false;
    update();
  }

  convertToInvisible1() {
    _obsecureText1.value = true;
    update();
  }

  convertToInvisible2() {
    _obsecureText2.value = true;
    update();
  }

  registerWithBody() async {
    _isLoading(true);

    if ((firstNameValidator(firstnameController.value.text) == null) &&
        (lastNameValidator(lastnameController.value.text) == null) &&
        (emailValidator(emailController.value.text) == null) &&
        (passwordValidator(passwordController.value.text) == null) &&
        (confirmpasswordValidator(confirmpasswordController.value.text) ==
            null)) {
    } else {
      debugPrint("Hello");
      _validationDisplay.value = true;
      update();
      return;
    }


    defaultSettings(String apikey, String userId) async {
    try {
      final request = SendBackgroundSettingsRequest(
        apikey: apikey,
        userId: int.parse(userId),
        backgroundimageId: QTAppConfigManager.config.defaultbackgroundimageId,
        fontfamilyId: QTAppConfigManager.config.defaultfontfamilyId,
        fontColorId: QTAppConfigManager.config.defaultfontColorId
      );
      final response =
          await ApiRepository.to.sendBackgroundSettings(request: request);

      if (response.status == 200) {
      
      } else {
        showErrorSnackbar(title: "Error", message: "Some error occured");
      }
    } catch (e) {
      showErrorSnackbar(title: "Error", message: e.toString());
    }
  }

    try {
      final request = SignUpRequest(
          firstName: firstnameController.value.text,
          lastName: lastnameController.value.text,
          email: emailController.value.text,
          password: passwordController.value.text,
          role: "USER");
      final response = await ApiRepository.to.signup(request: request);

      if (response.status == 201) {
        _signUpResponse.value = response.data;

        final qtSharedPreferences = QTSharedPreferences();
        String userid = signUpResponse!.userId;
        String firstName = signUpResponse!.firstName;
        String lastName = signUpResponse!.lastName;
        String email = signUpResponse!.email;
        String role = signUpResponse!.role;
        String apikey = signUpResponse!.apikey;
        String paymentEndDate = signUpResponse!.paymentEndDate ?? "";
        debugPrint(userid);
        await qtSharedPreferences.saveTokensToPrefs(
            userid, firstName, lastName, email, role, apikey,paymentEndDate);
        await defaultSettings(apikey,userid);
        await showSuccessSnackbar(title: "Success", message: "User successfully created");    
        await Future.delayed(const Duration(seconds: 2));
        //await Get.offAllNamed('/onboardfirst');
        await Get.offAllNamed('/dashboard');
      } else {
         showErrorSnackbar(title: "Error", message: "Some error occured");
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
}
