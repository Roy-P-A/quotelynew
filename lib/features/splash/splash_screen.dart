import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../widgets/custom_background.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                const CustomBackground(),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.toNamed("/signin");
                          },
                          child: SvgPicture.asset(
                            "assets/svgs/images/signin/logo.svg",
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Text(
                          "Quotely",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 50,
                        ),

                        SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: 
                        const Text(
                          "Your daily dose of motivation",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
