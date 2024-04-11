import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'perlistingsection_controller.dart';

class PerslistingSectionScreen extends StatelessWidget {
  const PerslistingSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerslistingSectionController>(
        init: PerslistingSectionController(),
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
              title: Text(
                controller.header,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            body:LoadingOverlay(
               isLoading: controller.isLoadingFetchImageSubCategories,
              color: Colors.transparent,
              opacity: 0.8,
              progressIndicator: const CircularProgressIndicator(
                color: Color(0xff744EFD),
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                height: double.infinity,
                child: controller.persListingsection.isEmpty
                    ? const Center(
                        child: Text(
                          "NO DATA FOUND",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    : GridView.builder(
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
                        itemCount: controller.persListingsection.length,
                        itemBuilder: (context, index) {
                          Uint8List bytes = base64Decode(
                              controller.persListingsection[index].image);
                          return GestureDetector(
                            onTap: () {
                              controller.prelistingSub(
                                  controller.persListingsection[index].id);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: MemoryImage(bytes),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  controller.persListingsection[index].quote,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: controller
                                        .persListingsection[index].fontFamily,
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
              ),
            ),
          );
        });
  }
}
