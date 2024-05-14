import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../widgets/custom_background.dart';
import 'onboardthird_controller.dart';

class OnBoardThirdScreen extends StatelessWidget {
  const OnBoardThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardThirdController>(
        init: OnboardThirdController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: const Color(0xff252525),
            body: LoadingOverlay(
              isLoading: controller.isLoadingFetchImageCategories,
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
                    // controller.getImageCategoriesDataContent.isEmpty
                    //     ? const Center(
                    //         child: Text(
                    //         "NO DATA FOUND",
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.bold),
                    //       ))
                    //     :

                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: const EdgeInsets.all(20.0),
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
                                      borderRadius: BorderRadius.circular(20),
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
                          controller.getImageCategoriesDataContent.isEmpty
                              ? const Center(
                                  child: Text(
                                  "NO DATA FOUND",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))
                              : Expanded(
                                child: ListView.separated(
                                   // shrinkWrap: true,
                                    controller: controller.scrollController,
                                    itemCount: controller
                                        .getImageCategoriesDataContent.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Uint8List bytes = base64Decode(controller
                                          .getImageCategoriesDataContent[index]
                                          .thumbnail);
                                      return GestureDetector(
                                        onTap: () {
                                          controller.selectPersonalizeListView(
                                              controller
                                                  .getImageCategoriesDataContent[
                                                      index]
                                                  .id,
                                              controller
                                                  .getImageCategoriesDataContent[
                                                      index]
                                                  .name);
                                        },
                                        child: Container(
                                          height: 137,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: MemoryImage(bytes),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Center(
                                            child: Text(
                                              controller
                                                  .getImageCategoriesDataContent[
                                                      index]
                                                  .name,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                              ),
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
