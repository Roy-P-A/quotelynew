import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dashboard.dart';

class BackgroundImage extends StatelessWidget {
  final DashboardController controller;
  const BackgroundImage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Image.memory(
            base64Decode(controller.fetchedBackgroundSettings!.image),
            filterQuality: FilterQuality.high,
          ),
        )));
  }
}
