import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton9 extends StatelessWidget {
  final String iconLink;

  final VoidCallback customFunction;
  const CustomButton9(
      {super.key, required this.iconLink, required this.customFunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: customFunction,
      child: Center(
        child: Container(
            height: 32,
            width: 32,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              
              shape: BoxShape.circle,
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
