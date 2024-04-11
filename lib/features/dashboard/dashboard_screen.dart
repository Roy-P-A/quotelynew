import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


import 'dashboard.dart';
import 'sections/background_image.dart';

import 'sections/quote_section/quote_section.dart';
import 'widgets/custombutton6.dart';
import 'widgets/custombuttonnew.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = Get.put(DashboardController());

  @override
  void dispose() {
    Get.delete<DashboardController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              RepaintBoundary(
                  key: controller.key, child: duplicateWidget(controller)),
              originalWidget(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget originalWidget(DashboardController controller) {
    return Obx(()=>Stack(
      children: [
        controller.fetchedBackgroundSettings != null
            ? BackgroundImage(
                controller: controller,
              )
            : Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
              ),
        SafeArea(
          child: Stack(
            children: [
              controller.fetchedBackgroundSettings != null
                  ? QuoteSection(
                      controller: controller,
                      screenChange: true,
                    )
                  : const SizedBox(),
              Positioned(
                right: 20,
                bottom: 20,
                child: CustomButton6(
                  controller: controller,
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: CustomButtonNew(
                  iconLink: "assets/svgs/images/dashboard/google.svg",
                  pageRoute: '/profile',
                  controller: controller,
                ),
              ),
            ],
          ),
        ),
      ],
    ),);
  }

  Widget duplicateWidget(DashboardController controller) {
    return Stack(
      children: [
        controller.fetchedBackgroundSettings != null
            ? BackgroundImage(
                controller: controller,
              )
            : Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
              ),
        Obx(()=>SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.fetchedBackgroundSettings != null
                  ? Expanded(
                      child: QuoteSection(
                        controller: controller,
                        screenChange: false,
                      ),
                    )
                  : const Expanded(child: SizedBox()),
            ],
          ),
        )),
      ],
    );
  }
}
