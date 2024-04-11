import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dashboard.dart';
import 'custombutton1.dart';
import 'custombutton7.dart';

class CustomButton6 extends StatelessWidget {
  final DashboardController controller;
  const CustomButton6({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (controller.isExpanded.value)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton1(
                  iconLink: "assets/svgs/images/dashboard/category.svg",
                  pageRoute: '/categories',
                  controller: controller,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton1(
                  iconLink: "assets/svgs/images/dashboard/pencil.svg",
                  pageRoute: '/perslisting',
                  controller: controller,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          controller.isExpanded.value
              ? CustomButton7(
                  iconLink: "assets/svgs/images/dashboard/close.svg",
                  customFunction: () => controller.toggleExpandedClose(),
                )
              : CustomButton7(
                  iconLink: "assets/svgs/images/dashboard/three_dots.svg",
                  customFunction: () => controller.toggleExpandedOpen(),
                )
        ],
      ),
    );
  }
}
