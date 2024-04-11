import 'package:flutter/widgets.dart';
import 'flavors.dart';
import 'motivation_app.dart';



Future<void> main() async {
  F.appFlavor = Flavor.prod;
  await initMotivationApp();
  runApp(const MotivationApp());
}
