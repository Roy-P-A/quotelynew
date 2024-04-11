import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sigin.dart';

class RememberMeAndForgotPassword extends StatelessWidget {
  final SignInController controller;
  const RememberMeAndForgotPassword({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              activeColor: const Color(0xff858585),
              hoverColor: const Color(0xff858585),
              focusColor: const Color(0xff858585),
              checkColor: Colors.black,
              value: controller.isChecked.value,
              onChanged: (value) => controller.toggleCheckbox(),
            ),
            const Text(
              "remember me",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff858585),
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: () {Get.toNamed('/forgotpassword');},
          child: Text(
            "Forgot Password ?",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff858585),
            ),
          ),
        )
      ],
    ),);
  }
}
