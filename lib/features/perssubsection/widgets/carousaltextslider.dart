import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../perssubsection.dart';

class MyCarouselTextSlider extends StatelessWidget {
  final PersSubSectionController controller;

  const MyCarouselTextSlider({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: Colors.transparent,
          height: 110,
          child: CarouselSlider.builder(
            carouselController: controller.carouselController1,
            itemCount: controller.fontList1.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Obx(() => GestureDetector(
                    onTap: () {
                      controller.carouselController1.animateToPage(index);
                    },
                    child: Center(
                      child: Container(
                        width: index == controller.selectedCenterIndex
                            ? 1.3 * 45
                            : 1.0 * 45,
                        height: index == controller.selectedCenterIndex
                            ? 1.3 * 45
                            : 1.0 * 45,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(40.0),
                          border: Border.all(
                            color: Colors.white,
                            width: index == controller.selectedCenterIndex
                                ? 3.0
                                : 0.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Aa',
                            style: TextStyle(
                              fontSize: index == controller.selectedCenterIndex
                                  ? 1.3 * 16
                                  : 1.0 * 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: controller.fontList1[index].fontname,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            },
            options: CarouselOptions(
              height: 150,
              viewportFraction: 0.2,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                controller.fontSelecter(index);
              },
            ),
          ),
        ));
  }
}
