import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarSettings extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      surfaceTintColor:Colors.transparent,
      leading: const SizedBox(),
      backgroundColor: const Color(0xffF4F4F4),
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: const Text(
                "Done",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              "Motivation",
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}
