import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../widgets/custom_background.dart';
import 'onboardfourth_controller.dart';

class OnboardFourthScreen extends StatelessWidget {
  const OnboardFourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardFourthController>(
        init: OnboardFourthController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: const Color(0xff252525),
            body: LoadingOverlay(
              isLoading: controller.isLoadingFetchImageSubCategories,
              color: Colors.transparent,
              opacity: 0.8,
              progressIndicator: const CircularProgressIndicator(
                color: Color(0xff744EFD),
              ),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    const CustomBackground(),
                    controller.persListingsection.isEmpty
                        ? const Center(
                            child: Text(
                              "NO DATA FOUND",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "2/4",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: 5,
                                          width: (150 / 4) * 2,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Choose the look you love",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Make quotely yours.Select a theme you love and we're done!",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Color(0xff8E8E8E),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GridView.builder(
                                    controller: controller.scrollController,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                      childAspectRatio: 0.66,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.persListingsection.length,
                                    itemBuilder: (context, index) {
                                      Uint8List bytes = base64Decode(controller
                                          .persListingsection[index].image);
                                      return GestureDetector(
                                        onTap: () {
                                          controller.prelistingSub(controller
                                              .persListingsection[index].id);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: MemoryImage(bytes),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              controller
                                                  .persListingsection[index]
                                                  .quote,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: controller
                                                    .persListingsection[index]
                                                    .fontFamily,
                                                fontSize: 20,
                                                color: index % 3 == 0
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
