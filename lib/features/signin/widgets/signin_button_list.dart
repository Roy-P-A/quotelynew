import 'dart:io';

import 'package:flutter/material.dart';

import '../../../widgets/custom_icon_button.dart';
import '../sigin.dart';

class SignInButtonList extends StatelessWidget {
  final SignInController controller;
  const SignInButtonList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          iconName: "assets/svgs/images/signin/google_icon.svg",
          functionName: () => controller.signInWithGoogle(),
        ),
        const SizedBox(
          width: 15,
        ),
        Platform.isIOS
            ? CustomIconButton(
                iconName: "assets/svgs/images/signin/apple_icon.svg",
                functionName: () => controller.signInWithApple(),
              )
            : const SizedBox(),
        Platform.isIOS
            ? const SizedBox(
                width: 15,
              )
            : const SizedBox(),
        CustomIconButton(
          iconName: "assets/svgs/images/signin/facebook_icon.svg",
          functionName: () => controller.signInWithFacebook(),
        )
      ],
    );
  }
}
