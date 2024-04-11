import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


import '../../widgets/custom_background.dart';

import 'forgotpassword.dart';
import 'widgets/firstsection.dart';
import 'widgets/secondsection.dart';
import 'widgets/thirdsection.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<ForgotPasswordController>(
          init: ForgotPasswordController(),
          builder: (controller) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  const CustomBackground(),
                  Container(
                    width: double.infinity,
                    // height: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: SafeArea(
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
                          Flexible(
                            child: PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: controller.pageController,
                              children: [
                                FirstSection(
                                  controller: controller,
                                ),
                                SecondSection(controller: controller),
                                ThirdSection(controller: controller)
                              ],
                            ),
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
                                  Get.offAllNamed("/signup");
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
                                MediaQuery.of(context).viewInsets.bottom / 10,
                          ),
                        ],
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
