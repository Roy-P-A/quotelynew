import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'favourites.dart';
import 'widgets/custom_fabbutton1.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritesController>(
        init: FavouritesController(),
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
              title: const Text(
                "Favourites",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              height: double.infinity,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.898,
                  ),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: controller.favourites.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage(controller.favourites[index].image),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                controller.favourites[index].quote,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily:
                                      controller.favourites[index].fontFamily,
                                  fontSize: 20,
                                  color: index % 3 == 0
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: const CustomFab1Button()),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
