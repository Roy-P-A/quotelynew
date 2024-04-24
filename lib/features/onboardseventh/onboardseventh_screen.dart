import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../widgets/custom_background.dart';
import 'onboardseventh_controller.dart';

class OnBoardSeventhScreen extends StatelessWidget {
  const OnBoardSeventhScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<OnboardSeventhController>(
          init: OnboardSeventhController(),
          builder: (controller) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: Stack(
                children: [
                  CustomBackground(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Get Premium \n Access",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Enjoy More Customizations and Themes and an ad free experience.",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              ". Remove Ads\n. More Fonts\n. More Themes",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              height: 200,
                              padding: const EdgeInsets.all(0.7),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.white, Colors.black],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  //color: Colors.transparent,
                                  color: const Color(0xff744EFD),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: const Stack(
                                  children: [
                                    Positioned(
                                      top: 12,
                                      left: 12,
                                      child: Text(
                                        "Standard",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      left: 12,
                                      child: Text(
                                        "₹ 699",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 36,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      right: 12,
                                      child: Text(
                                        "One Time Payment",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: SizedBox(
                height: 120,
                child: Column(
                  children: [
                       GestureDetector(
                      onTap: () {
                        Get.offAllNamed("/dashboard");
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            "Skip",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                   
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        decoration: BoxDecoration(
                            color: const Color(0xff744EFD),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            "Select Package",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
