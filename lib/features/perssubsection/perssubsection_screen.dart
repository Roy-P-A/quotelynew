import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'perssubsection_controller.dart';
import 'widgets/customfloatbutton.dart';
import 'widgets/glassyappbar.dart';

class PersSubSectionScreen extends StatelessWidget {
  const PersSubSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersSubSectionController>(
        init: PersSubSectionController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: const Color(0xff252525),
            body: controller.isLoadingImageFinished
                ? Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(
                                base64Decode(controller.fetchedImage!.image)),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: controller.isLoadingFinished &&
                                  controller.isLoadingColorFinished
                              ? Obx(() => Text(
                                    controller.quote,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(controller
                                          .colorList1[controller
                                              .selectedCenterIndexColor]
                                          .fontColor),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 32,
                                      fontFamily: controller
                                          .fontList1[
                                              controller.selectedCenterIndex]
                                          .fontname,
                                    ),
                                  ))
                              : null,
                        ),
                      ),
                      const GlassyAppbar(),
                    ],
                  )
                : Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: double.infinity,
                    child: const Center(
                      child: CircularProgressIndicator(
                         color: Color(0xff744EFD),
                      ),
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: controller.isLoadingFinished &&
                    controller.isLoadingColorFinished
                ? CustomFloatButton(
                    controller: controller,
                  )
                : null,
          );
        });
  }
}
