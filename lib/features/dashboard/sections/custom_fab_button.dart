import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dashboard.dart';

import '../widgets/custombutton5.dart';

class CustomFabButton extends StatelessWidget {
  final DashboardController controller;
  const CustomFabButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton5(
            iconLink: "assets/svgs/images/dashboard/share_one.svg",
            customFunction: () => controller.shareButton(context),
          ),
          const SizedBox(
            width: 12,
          ),

          CustomButton5(
            iconLink: controller.quoteList3[controller.pageIndex].isFavourite
                ? "assets/svgs/images/dashboard/filled_heart.svg"
                : "assets/svgs/images/dashboard/heart.svg",
            customFunction: () {
              debugPrint(controller.quoteList3[controller.pageIndex].isFavourite.toString());
              controller.heartToggleExpanded();},
          ),

          // CustomButton5(
          //   iconLink: controller.isHeartIconChanged.value
          //       ? "assets/svgs/images/dashboard/filled_heart.svg"
          //       : "assets/svgs/images/dashboard/heart.svg",
          //   customFunction: () => controller.heartToggleExpanded(),
          // ),
        ],
      ),
    );
  }
}
