import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../forgotpassword.dart';
import 'changepasswordtectfiledwidget3.dart';
import 'custom_button12.dart';
import 'customemailtextfieldwidget2.dart';

class ThirdSection extends StatelessWidget {
  final ForgotPasswordController controller;
  const ThirdSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Reset Password",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        const SizedBox(
          height: 30,
        ),
        const SizedBox(
          height: 18,
        ),
        CustomPasswordTextFieldWidget3(
          obscureText: controller.obsecureText1,
          controller: controller,
          tController: controller.passwordController.value,
          icon: "assets/svgs/images/signin/lock.svg",
          labelText: "Your Password",
          autovalidateMode: controller.validationDisplayThird
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          validator: (value) {
            return controller.passwordValidator(value!);
          },
          suffixIcon: controller.obsecureText1
              ? GestureDetector(
                  onTap: () => controller.convertToVisible1(),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      "assets/svgs/images/signin/not_visible.svg",
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () => controller.convertToInvisible1(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                        "assets/svgs/images/signin/visible_eye.svg"),
                  ),
                ),
        ),
        const SizedBox(
          height: 18,
        ),
        CustomPasswordTextFieldWidget3(
          obscureText: controller.obsecureText2,
          controller: controller,
          tController: controller.confirmpasswordController.value,
          icon: "assets/svgs/images/signin/lock.svg",
          labelText: "Your Password",
          autovalidateMode: controller.validationDisplayThird
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          validator: (value) {
            return controller.confirmpasswordValidator(value!);
          },
          suffixIcon: controller.obsecureText2
              ? GestureDetector(
                  onTap: () => controller.convertToVisible2(),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      "assets/svgs/images/signin/not_visible.svg",
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () => controller.convertToInvisible2(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                        "assets/svgs/images/signin/visible_eye.svg"),
                  ),
                ),
        ),
        const SizedBox(
          height: 18,
        ),
        CustomButton12(
          controller: controller,
          buttonText: "Submit",
          tapfunction: () {
            controller.tokenChangePassword();
          },
        ),
      ],
    );
  }
}
