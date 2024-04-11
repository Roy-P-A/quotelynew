import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../profile.dart';

class ProfileSection extends StatelessWidget {
  final ProfileController controller;
  const ProfileSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    Widget bannerWidget;
    switch (controller.isBannerChecker1) {
      case 0:
        bannerWidget = profileguest(controller);
        break;
      case 1:
        bannerWidget = profileuser(controller);
        break;
      case 2:
        bannerWidget = profileuserPremium(controller);
        break;
      default:
        bannerWidget = Container(); // Or any default widget if needed
    }

    return bannerWidget;
  }

  Container profileuser(ProfileController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff191919),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile/profile_icon.png",
            width: 60,
            height: 60,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${controller.firstname} ${controller.lastname}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${controller.email}",
                style: const TextStyle(color: Color(0xff8E8E8E), fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget profileguest(ProfileController controller) {
    return GestureDetector(
      onTap: () {controller.profileGuestTap();},
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff191919),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/profile/profile_guest.png",
              width: 60,
              height: 60,
            ),
            const SizedBox(
              width: 15,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login/Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Login to customize your experience",
                  style: TextStyle(color: Color(0xff8E8E8E), fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container profileuserPremium(ProfileController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff191919),
      ),
      child: Row(
        
        children: [
          Image.asset(
            "assets/images/profile/profile_icon.png",
            width: 60,
            height: 60,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${controller.firstname} ${controller.lastname}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${controller.email}",
                style: TextStyle(color: Color(0xff8E8E8E), fontSize: 12),
              )
            ],
          ),
          const Expanded(
            child:  SizedBox(
              width: 15,
            ),
          ),
          SvgPicture.asset(
            "assets/svgs/images/profile/crown_yellow.svg",
          ),
        ],
      ),
    );
  }
}
