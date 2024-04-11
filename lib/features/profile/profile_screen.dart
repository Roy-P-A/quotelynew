import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'profile.dart';
import 'sections/general_settings.dart';
import 'sections/logout_list_section.dart';
import 'sections/profile_section.dart';
import 'sections/support_settings.dart';
import 'widgets/quote_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: const Color(0xff0E0E0E),
              leading: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff262626),
                  ),
                  child: SvgPicture.asset(
                    "assets/svgs/images/profile/arrow.svg",
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            body: SafeArea(
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: SingleChildScrollView(
                  controller: controller.scrollController1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      ProfileSection(
                        controller: controller,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "General",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GeneralSettings(controller: controller),
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Support",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SupportSettings(controller: controller),
                      const SizedBox(
                        height: 15,
                      ),
                      LogoutListSection(controller: controller),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
