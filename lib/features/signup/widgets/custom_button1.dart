import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../signup.dart';

class CustomButton1 extends StatelessWidget {
  final SignUpController controller;
  const CustomButton1({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed("/dashboard");
        controller.registerWithBody();
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff744EFD),
        ),
        child: const Center(
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}