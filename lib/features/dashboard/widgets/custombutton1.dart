import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../dashboard.dart';



class CustomButton1 extends StatelessWidget {
  final String iconLink;
  final String pageRoute;
  final DashboardController controller;
  const CustomButton1({super.key, required this.iconLink, required this.pageRoute,required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => {
        controller.customButton1Function(context,pageRoute)
        //Get.toNamed(pageRoute)
      },
      child: Center(
        child: Container(
          height: 45,
          width: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withOpacity(0.2),
          ),
          child: SvgPicture.asset(iconLink,height: 18,width: 18,)
        ),
      ),
    );
  }
}
