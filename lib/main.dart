import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quotely1/flavors.dart';
import 'motivation_app.dart';


FutureOr<void> main() async {
  F.appFlavor = Flavor.dev;
  await initMotivationApp();
  runApp(const MotivationApp());
}