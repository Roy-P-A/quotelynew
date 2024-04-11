import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'perslisting_controller.dart';
import 'widgets/prelisting1.dart';

class PerslistingScreen extends StatelessWidget {
  const PerslistingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerslistingController>(
        init: PerslistingController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: const Color(0xff252525),
            appBar: AppBar(
              backgroundColor: const Color(0xff3B3B3B),
              leading: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff3B3B3B),
                  ),
                  child: SvgPicture.asset(
                    "assets/svgs/images/profile/arrow.svg",
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
              centerTitle: true,
              title: const Text(
                "Personalize",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            body: LoadingOverlay(
              isLoading: controller.isLoadingFetchImageCategories,
              color: Colors.transparent,
              opacity: 0.8,
              progressIndicator: const CircularProgressIndicator(
                color: Color(0xff744EFD),
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                height: double.infinity,
                child: controller.getImageCategoriesDataContent.isEmpty
                    ? const Center(
                        child: Text(
                        "NO DATA FOUND",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))
                    : ListView.separated(
                        controller: controller.scrollController,
                        itemCount:
                            controller.getImageCategoriesDataContent.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          Uint8List bytes = base64Decode(controller
                              .getImageCategoriesDataContent[index].thumbnail);
                          return GestureDetector(
                            onTap: () {
                              controller.selectPersonalizeListView(
                                  controller
                                      .getImageCategoriesDataContent[index].id,
                                  controller
                                      .getImageCategoriesDataContent[index].name);
                            },
                            child: Container(
                              height: 137,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: MemoryImage(bytes),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  controller
                                      .getImageCategoriesDataContent[index]
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
            ),
          );
        });
  }
}
