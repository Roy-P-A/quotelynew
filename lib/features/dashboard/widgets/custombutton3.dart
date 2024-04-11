import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



class CustomButton3 extends StatelessWidget {
  final String iconLink;
  final String pageRoute;
  const CustomButton3({super.key, required this.iconLink, required this.pageRoute});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => {
        Get.toNamed(pageRoute)
      },
      child: Center(
        child: Container(
          height: 40,
          width: 40,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withOpacity(0.1),
          ),
          child: SvgPicture.asset(iconLink,height: 18,width: 18,)
        ),
      ),
    );
  }
}