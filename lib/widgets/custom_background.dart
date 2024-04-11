import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xff1D1D1D),
        ),
      
        Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 1,
            colors: [
              const Color(0xff7559FD).withOpacity(0.6),
              Colors.transparent
            ],
          )),
        ),
        Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
              center: Alignment.bottomCenter,
              radius: 0.4,
            colors: [
              const Color(0xff7559FD).withOpacity(0.4),
              Colors.transparent
            ],
          )),
        ),
      ],
    );
  }
}