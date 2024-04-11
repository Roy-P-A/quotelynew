import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../perssubsection.dart';

// class MyCarouselColorSlider extends StatelessWidget {
//   final PersSubSectionController controller;
//   const MyCarouselColorSlider({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       height: 110,
//       child: CarouselSlider.builder(
//         itemCount: controller.colorList1.length,
//         itemBuilder: (BuildContext context, int index, int realIndex) {
//           double scaleFactor =
//               index == controller.selectedCenterIndexColor ? 1.3 : 1.0;
//           return Center(
//             child: Container(
//               width: 45.0 *scaleFactor ,
//               height: 45.0 * scaleFactor ,
//               decoration: BoxDecoration(
//                 color: Color(controller.colorList1[index].color),
//                 borderRadius: BorderRadius.circular(40.0),
//                 border: Border.all(
//                   color: Colors.white,
//                   width: index == controller.selectedCenterIndexColor ? 3.0 : 0.0,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   '',
//                   style: TextStyle(
//                     fontSize: 16.0 * scaleFactor,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//         options: CarouselOptions(
//           height: 150,
//           viewportFraction: 0.2,
//           enlargeCenterPage: true,
//           onPageChanged: (index, reason) {
//             controller.colorSelecter(index);
//           },
//         ),
//       ),
//     );
//   }
// }

class MyCarouselColorSlider extends StatelessWidget {
  final PersSubSectionController controller;

  const MyCarouselColorSlider({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: Colors.transparent,
          height: 110,
          child: CarouselSlider.builder(
            carouselController: controller.carouselController,
            itemCount: controller.colorList1.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              double scaleFactor =
                  index == controller.selectedCenterIndexColor ? 1.3 : 1.0;
              return Obx(() => GestureDetector(
                    onTap: () {
                      // Set the selected item to be centered
                      controller.carouselController.animateToPage(index);
                    },
                    child: Center(
                      child: Container(
                        width: index == controller.selectedCenterIndexColor
                            ? 1.3 * 45
                            : 1.0 * 45,
                        height: index == controller.selectedCenterIndexColor
                            ? 1.3 * 45
                            : 1.0 * 45,
                        decoration: BoxDecoration(
                          color: Color(controller.colorList1[index].fontColor),
                          borderRadius: BorderRadius.circular(40.0),
                          border: Border.all(
                            color: Colors.white,
                            width: index == controller.selectedCenterIndexColor
                                ? 3.0
                                : 0.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '',
                            style: TextStyle(
                              fontSize: 16.0 * scaleFactor,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
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
                controller.colorSelecter(index);
              },
            ),
          ),
        ));
  }
}
