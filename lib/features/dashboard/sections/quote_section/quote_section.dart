import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../dashboard.dart';
import '../custom_fab_button.dart';
import 'quote_list.dart';

class QuoteSection extends StatelessWidget {
  final DashboardController controller;
  final bool screenChange;
  QuoteSection(
      {super.key, required this.controller, required this.screenChange});
  //final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragEnd: (DragEndDetails details) {
          if (details.velocity.pixelsPerSecond.dy > 0) {
            // Swiped from top to bottom
            controller.pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else if (details.velocity.pixelsPerSecond.dy < 0) {
            // Swiped from bottom to top
            controller.pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: PageView.builder(
            scrollDirection: Axis.vertical,
            controller: controller.pageController,
            // PageController(
            //     initialPage: 0, keepPage: true, viewportFraction: 1),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.quoteList3.length,

            itemBuilder: (context, index) {
              controller.indexNotifying(index);
              return oneQuotePageSection(
                  context, index, controller, screenChange);
            }),
      ),
    ),);
  }

  Widget oneQuotePageSection(BuildContext context, int index,
      DashboardController controller, bool screenchange) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width / 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.quoteList3[controller.pageIndex].quote,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: controller.fetchedBackgroundSettings!.fontname,
                  color: Color(int.parse(
                      controller.fetchedBackgroundSettings!.fontcolor)),
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            screenChange == true
                ? CustomFabButton(controller: controller)
                : const SizedBox(),
            screenChange == true
                ? const SizedBox()
                : Container(
                    child: SvgPicture.asset(
                      "assets/svgs/images/dashboard/quotelybanner.svg",
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
