import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WebViewPage extends StatelessWidget {
  final String websiteAddress;

  const WebViewPage({super.key, required this.websiteAddress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff323232),
        leading: GestureDetector(
          onTap:(){
            Get.back();
          },
          child: Container(
            padding: const EdgeInsets.all(18),
            width: 10,
            height: 10,
            child: SvgPicture.asset(
                      "assets/svgs/images/profile/arrow.svg",
                      height: 10,
                      width: 10,
                    ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Quotely',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:
        const SizedBox(),
      
      //  InAppWebView(
      //   initialUrlRequest: URLRequest(
      //     url: Uri.parse(websiteAddress),
      //   ),
      //   onWebViewCreated: (controller) {
      //     // You can access the controller here if needed.
      //   },
      //   initialOptions: InAppWebViewGroupOptions(
      //     crossPlatform: InAppWebViewOptions(),
      //   ),
      // ),
    );
  }
}
