

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatelessWidget {
  final String iconName;
  final VoidCallback functionName;
  const CustomIconButton({super.key, required this.iconName, required this.functionName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: functionName,
      child: Container(
        padding: const EdgeInsets.all(8.0),
         decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.4)),
          color: Colors.grey.withOpacity(0.2),
        ),
        child: SvgPicture.asset(iconName),
      ),
    );
  }
}