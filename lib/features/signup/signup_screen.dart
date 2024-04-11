import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


import '../../widgets/custom_background.dart';
import 'signup_controller.dart';
import 'widgets/custom_button1.dart';
import 'widgets/custom_textfield1.dart';
import 'widgets/custom_textfield2.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<SignUpController>(
          init: SignUpController(),
          builder: (controller) {
            return Obx(() => Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: Stack(
                    children: [
                      const CustomBackground(),
                      Container(
                        width: double.infinity,
                        // height: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: SafeArea(
                          child: SingleChildScrollView(
                            reverse: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                SvgPicture.asset(
                                  "assets/svgs/images/signin/logo.svg",
                                  height: 80,
                                  width: 80,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    CustomTextFieldWidget1(
                                      obscureText: false,
                                      controlleer: controller,
                                      tController:
                                          controller.firstnameController.value,
                                      icon:
                                          "assets/svgs/images/signin/user.svg",
                                      labelText: "First name",
                                      autovalidateMode:
                                          controller.validationDisplay
                                              ? AutovalidateMode.always
                                              : AutovalidateMode.disabled,
                                      validator: (value) {
                                        return controller
                                            .firstNameValidator(value!);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    CustomTextFieldWidget1(
                                      obscureText: false,
                                      controlleer: controller,
                                      tController:
                                          controller.lastnameController.value,
                                      icon:
                                          "assets/svgs/images/signin/user.svg",
                                      labelText: "Last name",
                                      autovalidateMode:
                                          controller.validationDisplay
                                              ? AutovalidateMode.always
                                              : AutovalidateMode.disabled,
                                      validator: (value) {
                                        return controller
                                            .lastNameValidator(value!);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    CustomTextFieldWidget1(
                                      obscureText: false,
                                      controlleer: controller,
                                      tController:
                                          controller.emailController.value,
                                      icon:
                                          "assets/svgs/images/signin/email.svg",
                                      labelText: "Your mail address",
                                      autovalidateMode:
                                          controller.validationDisplay
                                              ? AutovalidateMode.always
                                              : AutovalidateMode.disabled,
                                      validator: (value) {
                                        return controller
                                            .emailValidator(value!);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    CustomTextFieldWidget2(
                                      obscureText: controller.obsecureText2,
                                      controller: controller,
                                      tController:
                                          controller.passwordController.value,
                                      icon:
                                          "assets/svgs/images/signin/lock.svg",
                                      labelText: "Create Password",
                                      autovalidateMode:
                                          controller.validationDisplay
                                              ? AutovalidateMode.always
                                              : AutovalidateMode.disabled,
                                      validator: (value) {
                                        return controller
                                            .passwordValidator(value!);
                                      },
                                      suffixIcon: controller.obsecureText2
                                          ? GestureDetector(
                                              onTap: () => controller
                                                  .convertToVisible2(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: SvgPicture.asset(
                                                  "assets/svgs/images/signin/not_visible.svg",
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () => controller
                                                  .convertToInvisible2(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SvgPicture.asset(
                                                    "assets/svgs/images/signin/visible_eye.svg"),
                                              ),
                                            ),
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    CustomTextFieldWidget2(
                                      obscureText: controller.obsecureText1,
                                      controller: controller,
                                      tController: controller
                                          .confirmpasswordController.value,
                                      icon:
                                          "assets/svgs/images/signin/lock.svg",
                                      labelText: "Confirm Password",
                                      autovalidateMode:
                                          controller.validationDisplay
                                              ? AutovalidateMode.always
                                              : AutovalidateMode.disabled,
                                      validator: (value) {
                                        return controller
                                            .confirmpasswordValidator(value!);
                                      },
                                      suffixIcon: controller.obsecureText1
                                          ? GestureDetector(
                                              onTap: () => controller
                                                  .convertToVisible1(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: SvgPicture.asset(
                                                  "assets/svgs/images/signin/not_visible.svg",
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () => controller
                                                  .convertToInvisible1(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SvgPicture.asset(
                                                    "assets/svgs/images/signin/visible_eye.svg"),
                                              ),
                                            ),
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    CustomButton1(
                                      controller: controller,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already a user? ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.offAllNamed("/signin");
                                      },
                                      child: const Text(
                                        "Sign In",
                                        style: TextStyle(
                                          color: Color(0xff744EFD),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).viewInsets.bottom /
                                          10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
}
