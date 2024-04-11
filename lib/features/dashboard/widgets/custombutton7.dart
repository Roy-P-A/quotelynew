import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton7 extends StatelessWidget {
  final String iconLink;

  final VoidCallback customFunction;
  const CustomButton7(
      {super.key, required this.iconLink, required this.customFunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: customFunction,
      child: Center(
        child: Container(
            height: 45,
            width: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(12),
           
              color: Colors.white.withOpacity(0.2),
            ),
            child: SvgPicture.asset(
              iconLink,
              height: 18,
              width: 18,
            )),
      ),
    );
  }
}