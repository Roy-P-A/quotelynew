import 'package:flutter/material.dart';

import '../forgotpassword.dart';
import 'custom_button12.dart';
import 'customemailtextfieldwidget2.dart';

class FirstSection extends StatelessWidget {
  final ForgotPasswordController controller;
  const FirstSection({super.key,required this.controller});

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
              controller.emailController.value,
          icon: "assets/svgs/images/signin/email.svg",
          labelText: "Your mail address",
          autovalidateMode:
              controller.validationDisplayFirst
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
          buttonText: "Send Reset Code",
          tapfunction: ()=> controller.sendResetcodeFunction(),
        ),
      ],
    );
  }
}
