import 'package:flutter/material.dart';
import '../perssubsection.dart';
import 'carousalcolorslider.dart';
import 'carousaltextslider.dart';
import 'custombutton8.dart';

class CustomFloatButton extends StatelessWidget {
  final PersSubSectionController controller;
  const CustomFloatButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          controller.buttonShow2
              ? MyCarouselColorSlider(
                  controller: controller,
                )
              : const SizedBox(),
          controller.buttonShow2
              ? const SizedBox()
              : MyCarouselTextSlider(
                  controller: controller,
                ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    controller.buttonShow2
                        ? CustomButton8(
                            iconLink: "assets/svgs/images/dashboard/Aa.svg",
                            customFunction: () {
                              controller.textButtonActivate();
                            },
                          )
                        : const SizedBox(),
                    controller.buttonShow2
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () {
                              controller.colorBurronActivate();
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                  ],
                ),
                CustomButton8(
                  iconLink: "assets/svgs/images/dashboard/charm_tick.svg",
                  customFunction: () {
                    controller.submitFunction();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
