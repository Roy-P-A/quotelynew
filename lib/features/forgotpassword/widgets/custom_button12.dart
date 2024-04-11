import 'package:flutter/material.dart';

import '../forgotpassword.dart';



class CustomButton12 extends StatelessWidget {
  final ForgotPasswordController controller;
  final String buttonText;
  final VoidCallback tapfunction;
  const CustomButton12({super.key,required this.controller,required this.buttonText,required this.tapfunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapfunction,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff744EFD),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
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