import 'package:flutter/material.dart';

import '../forgotpassword.dart';
import 'custom_button12.dart';
import 'customemailtextfieldwidget2.dart';

class SecondSection extends StatelessWidget {
  final ForgotPasswordController controller;
  const SecondSection({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Forgot Password",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        const SizedBox(
          height: 30,
        ),
        CustomEmailTextFieldWidget2(
          obscureText: false,
          controlleer: controller,
          tController:
              controller.codeController.value,
          icon: "assets/svgs/images/signin/key-square.svg",
          labelText: "Enter your code",
          autovalidateMode:
              controller.validationDisplaySecond
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
          validator: (value) {
            return controller.emailValidator(value!);
          },
        ),
        const SizedBox(
          height: 18,
        ),
        CustomButton12(
          controller: controller,
          buttonText: "Submit Code",
          tapfunction: (){controller.sendResetcodeSecondFunction();},
        ),
      ],
    );
  }
}