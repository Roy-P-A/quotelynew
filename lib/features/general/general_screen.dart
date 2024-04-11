
import 'package:flutter/material.dart';

class GeneralScreen extends StatelessWidget {
  const GeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: [
              Text("Categories"),
            
              Text("Most Popular"),

              Text("For You"),

              Text("Hard Times")
            ],
          ),
        ),
      ),
    );
  }
}