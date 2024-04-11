import 'package:flutter/material.dart';

import 'custombutton9.dart';


class CustomFab1Button extends StatelessWidget {
  const CustomFab1Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton9(
          iconLink: "assets/svgs/images/dashboard/share_one.svg",
          customFunction: () {},
        ),
        const SizedBox(
          width: 5,
        ),
        CustomButton9(
          iconLink: "assets/svgs/images/dashboard/filled_heart.svg",
          customFunction: () {},
        ),
      ],
    );
  }
}
