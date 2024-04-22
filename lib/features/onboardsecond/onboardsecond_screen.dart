import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'onboardsecond_controller.dart';

class OnboardSecondScreen extends StatelessWidget {
  const OnboardSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardSecondController>(
        init: OnboardSecondController(),
        builder: (controller) {
          return Obx(() => Scaffold(
                backgroundColor: const Color(0xff252525),
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: const Color(0xff252525),
                  leading: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff252525),
                      ),
                      child: SvgPicture.asset(
                        "assets/svgs/images/profile/arrow.svg",
                        height: 10,
                        width: 10,
                      ),
                    ),
                  ),
                  title: const Text(
                    "Categories",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                body: (controller.isLoadingCategoryFinished)
                    ? Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                        width: double.infinity,
                        height: double.infinity,
                        child: SingleChildScrollView(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 1,
                                ),
                                primary: false,
                                shrinkWrap: true,
                                itemCount:
                                    controller.categoryFetchConverted.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.tapCategory(controller
                                          .categoryFetchConverted[index]);
                                    },
                                    child: LayoutBuilder(
                                        builder: (context, constraints) {
                                      Uint8List bytes = base64Decode(controller
                                          .categoryFetch[index].categoryImage);
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: MemoryImage(bytes),
                                            fit: BoxFit.fill,
                                          ),
                                          border: controller
                                                  .categoryFetchConverted[index]
                                                  .isSelected
                                              ? Border.all(
                                                  color: const Color(
                                                      0xff744EFD), // Set the border color
                                                  width:
                                                      2.0, // Set the border width
                                                )
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              right: 10,
                                              top: 10,
                                              child: controller
                                                      .categoryFetchConverted[
                                                          index]
                                                      .isSelected
                                                  ? Container(
                                                      height: 32,
                                                      width: 32,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: const Color(
                                                              0xff744EFD),
                                                          border: Border.all(
                                                            color: Colors
                                                                .white, // Set the border color
                                                            width:
                                                                1.0, // Set the border width
                                                          )),
                                                      child: const Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 32,
                                                      width: 32,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white
                                                              .withOpacity(0.2),
                                                          border: Border.all(
                                                            color: Colors
                                                                .white, // Set the border color
                                                            width:
                                                                1.0, // Set the border width
                                                          )),
                                                    ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(0.0),
                                                  topRight:
                                                      Radius.circular(0.0),
                                                  bottomLeft:
                                                      Radius.circular(9.0),
                                                  bottomRight:
                                                      Radius.circular(9.0),
                                                ),
                                                child: ClipRect(
                                                  child: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                        sigmaX: 5, sigmaY: 5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  0.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  0.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  18.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  18.0),
                                                        ),
                                                      ),
                                                      width:
                                                          constraints.maxWidth,
                                                      height: (constraints
                                                              .maxHeight) *
                                                          0.2,
                                                      child: Center(
                                                        child: Text(
                                                          controller
                                                              .categoryFetchConverted[
                                                                  index]
                                                              .categoryName,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
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
                                }),
                          ],
                        )),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff744EFD),
                        ),
                      ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Container(
                  height: 110,
                  child: Column(
                    children: [
                      Text(
                        "${controller.numberOfCategorySelected}/${controller.totalCategories.toString()} Selected",
                        style: TextStyle(
                          color: Color(0xff8E8E8E),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.sendingSelectedCategory();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          decoration: BoxDecoration(
                              color: const Color(0xff744EFD),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Text(
                              "Next",
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
              ));
        });
  }
}
