import 'package:flutter/material.dart';

import '../favourites_controller.dart';
import 'custombutton9.dart';


class CustomFab1Button extends StatelessWidget {
  final FavouritesController controller;
  final GlobalKey key1;
  const CustomFab1Button({super.key,required this.controller,     required this.key1});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton9(
          iconLink: "assets/svgs/images/dashboard/share_one.svg",
          customFunction: () {
             controller.shareImageToSocialMedia1(key1);
          },
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
