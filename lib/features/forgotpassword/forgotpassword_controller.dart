import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dtos/api_dtos/forgotpassword/changepassbyforgot/changepassbyforgot.dart';
import '../../dtos/api_dtos/forgotpassword/sendemail/sendemail.dart';
import '../../dtos/api_dtos/forgotpassword/sendresettoken/sendresettoken.dart';
import '../../mixins/snackbar_mixin.dart';
import '../../models/forgotpassword/sendresettoken_model.dart';
import '../../repository/repository.dart';
import '../../utils/utils.dart';

class ForgotPasswordController extends GetxController with SnackbarMixin {
  PageController pageController = PageController(initialPage: 0);
  var emailController = TextEditingController().obs;
  var codeController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmpasswordController = TextEditingController().obs;

  final _validationDisplayFirst = false.obs;
  bool get validationDisplayFirst => _validationDisplayFirst.value;

  final _validationDisplaySecond = false.obs;
  bool get validationDisplaySecond => _validationDisplaySecond.value;

  final _validationDisplayThird = false.obs;
  bool get validationDisplayThird => _validationDisplayThird.value;

  final _activeStep = 0.obs;
  int get activeStep => _activeStep.value;

  final _sendResetTokenDataModel = Rx<SendResetTokenModel?>(null);
  SendResetTokenModel? get sendResetTokenDataModel =>
      _sendResetTokenDataModel.value;

  final _obsecureText1 = true.obs;
  bool get obsecureText1 => _obsecureText1.value;

  final _obsecureText2 = true.obs;
  bool get obsecureText2 => _obsecureText2.value;

  @override
  void onInit() async {
    initFunction();
    pageController = PageController(initialPage: activeStep);
    pageController.addListener(() {
      _activeStep.value = pageController.page!.round();
      update();
    });

    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  initFunction() {
    _validationDisplayFirst.value = false;
    _validationDisplaySecond.value = false;
    _activeStep.value = 0;
    emailController.value.clear();
    codeController.value.clear();
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return "Email-id is required";
    } else if (!isValidEmail(emailController.value.text)) {
      return "Invalid email";
    }
    return null;
  }

  String? codeValidator(String value) {
    if (value.isEmpty) {
      return "Code is required";
    } else if (value.length != 10) {
      return "Invalid Code";
    }
    return null;
  }

  sendResetcodeFunction() async {
    if (emailValidator(emailController.value.text) == null) {
    } else {
      _validationDisplayFirst.value = true;
      update();
      return;
    }

    try {
      final request = SendEmailRequest(email: emailController.value.text);
      final response =
          await ApiRepository.to.sendEmailForForgotPassword(request: request);
      if (response.status == 200) {
        showSuccessSnackbar(
            title: "Error", message: "Reset email send successfully");
        await Future.delayed(const Duration(seconds: 2), () {});
        await firstSubmitFunction();
      } else {}
    } catch (e) {
      showErrorSnackbar(title: "Error", message: e.toString());
      debugPrint(e.toString());
    }
  }

  firstSubmitFunction() {
    _activeStep.value = 1;
    pageController.animateToPage(
      _activeStep.value,
      duration: const Duration(milliseconds: 300), // Adjust duration as needed
      curve: Curves.easeInOut, // Adjust curve as needed
    );
  }

  sendResetcodeSecondFunction() async {
    if (codeValidator(codeController.value.text) == null) {
    } else {
      _validationDisplaySecond.value = true;
      update();
      return;
    }

    try {
      final request = SendResetTokenRequest(token: codeController.value.text);
      final response =
          await ApiRepository.to.sendResetTokenForgotPassword(request: request);
      if (response.status == 200) {
        _sendResetTokenDataModel.value = response.data;
        await Future.delayed(const Duration(seconds: 2), () {});
        await secondSubmitFunction();
      } else {}
    } catch (e) {
      showErrorSnackbar(title: "Error", message: e.toString());
      debugPrint(e.toString());
    }
  }

  secondSubmitFunction() {
    _activeStep.value = 2;
    pageController.animateToPage(
      _activeStep.value,
      duration: const Duration(milliseconds: 300), // Adjust duration as needed
      curve: Curves.easeInOut, // Adjust curve as needed
    );
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

  tokenChangePassword() async {
    if ((passwordValidator(passwordController.value.text) == null) &&
        (confirmpasswordValidator(confirmpasswordController.value.text) ==
            null)) {
    } else {
      _validationDisplayThird.value = true;
      update();
      return;
    }

    try {
      final request = ChangePasswordForgotRequest(
        id: sendResetTokenDataModel!.id,
        userId: sendResetTokenDataModel!.userId,
        token: sendResetTokenDataModel!.token,
        apikey: sendResetTokenDataModel!.apikey,
        password: passwordController.value.text,
      );
      final response =
          await ApiRepository.to.tokenChangePassword(request: request);
      if (response.status == 200) {
        showSuccessSnackbar(
            title: "Success", message: "Password changed successfully");
        await Future.delayed(const Duration(seconds: 2), () {});
        await Get.offAllNamed('/signin');
      } else {}
    } catch (e) {
      showErrorSnackbar(title: "Error", message: e.toString());
      debugPrint(e.toString());
    }
  }
}
