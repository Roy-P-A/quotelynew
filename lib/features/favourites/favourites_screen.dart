import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'favourites.dart';
import 'widgets/custom_fabbutton1.dart';
import 'widgets/favouritelist.dart';

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
            body: LoadingOverlay(
              isLoading: controller.isLoadingShare,
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                height: double.infinity,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 0.898,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: controller.favouriteList.length,
                    itemBuilder: (context, index) {
                      var itemKey = GlobalKey();
                      return GestureDetector(
                        onTap: () {},
                        child: RepaintBoundary(
                          key: itemKey,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(controller
                                    .favouriteList[index].backgroundImage),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    controller.favouriteList[index].quote,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: controller
                                          .favouriteList[index].fontFamily,
                                      fontSize: 20,
                                      color: Color(controller
                                          .favouriteList[index].fontColor),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Obx(()=>Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: controller.isModified == true
                                      ? const SizedBox()
                                      : CustomFab1Button(
                                          controller: controller,
                                          key1: itemKey),
                                ),)
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          );
        });
  }
}
