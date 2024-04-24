import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../widgets/custom_background.dart';
import 'onboardfirst.dart';

// class OnboardfirstScreen extends StatelessWidget {
//   const OnboardfirstScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class OnboardfirstScreen extends StatelessWidget {
  const OnboardfirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<OnboardFirstController>(
          init: OnboardFirstController(),
          builder: (controller) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: Stack(
                children: [
                  const CustomBackground(),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: SafeArea(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          SvgPicture.asset(
                            "assets/svgs/images/signin/logo.svg",
                            height: 80,
                            width: 80,
                          ),
                          const Text(
                            "Quotely",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: double.infinity,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome to Quotely",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Before we begin, let's know what best suits your needs",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xff8e8e8e),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed("/onboardsecond");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff744EFD),
                        ),
                        child: const Center(
                          child: Text(
                            "Set up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
