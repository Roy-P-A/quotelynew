import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../widgets/custom_background.dart';
import 'sections/remember_me_forgot_password.dart';
import 'signin_controller.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_email_textfield_widget.dart';
import 'widgets/custom_password_textfield_widget.dart';
import 'widgets/signin_button_list.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<SignInController>(
          init: SignInController(),
          builder: (controller) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: Stack(
                children: [
                  const CustomBackground(),
                  Container(
                    width: double.infinity,
                    // height: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: SafeArea(
                      child: Obx(
                        () => SingleChildScrollView(
                          reverse: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              SvgPicture.asset(
                                "assets/svgs/images/signin/logo.svg",
                                height: 80,
                                width: 80,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Log In",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  CustomEmailTextFieldWidget(
                                    obscureText: false,
                                    controlleer: controller,
                                    tController:
                                        controller.emailController.value,
                                    icon: "assets/svgs/images/signin/email.svg",
                                    labelText: "Your mail address",
                                    autovalidateMode:
                                        controller.validationDisplay
                                            ? AutovalidateMode.always
                                            : AutovalidateMode.disabled,
                                    validator: (value) {
                                      return controller.emailValidator(value!);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  CustomPasswordTextFieldWidget(
                                    obscureText: controller.obsecureText,
                                    controller: controller,
                                    tController:
                                        controller.passwordController.value,
                                    icon: "assets/svgs/images/signin/lock.svg",
                                    labelText: "Your Password",
                                    autovalidateMode:
                                        controller.validationDisplay
                                            ? AutovalidateMode.always
                                            : AutovalidateMode.disabled,
                                    validator: (value) {
                                      return controller
                                          .passwordValidator(value!);
                                    },
                                    suffixIcon: controller.obsecureText
                                        ? GestureDetector(
                                            onTap: () =>
                                                controller.convertToVisible(),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: SvgPicture.asset(
                                                "assets/svgs/images/signin/not_visible.svg",
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () =>
                                                controller.convertToInvisible(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: SvgPicture.asset(
                                                  "assets/svgs/images/signin/visible_eye.svg"),
                                            ),
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  RememberMeAndForgotPassword(
                                    controller: controller,
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  CustomButton(
                                    controller: controller,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "or continue with",
                                style: TextStyle(
                                    color: Color(0xff858585), fontSize: 15),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SignInButtonList(
                                controller: controller,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.signUpAsGuest();
                                },
                                child: Text(
                                  "Sign in as guest",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(color: Color(0xffA5A5A5)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed("/signup");
                                    },
                                    child: const Text(
                                      "Sign up",
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
                  ),
                ],
              ),
            );
          }),
    );
  }
}
