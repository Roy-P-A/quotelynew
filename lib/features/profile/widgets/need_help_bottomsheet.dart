import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/utils.dart';

class NeedHelpBottomSheet {
  void openGmailApp() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path:
          'support@nintriva.com', // Replace with the recipient's email address
    );

    if (!await launchUrl(emailLaunchUri,
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch gmail');
    }
  }

  void needHelpBottomSheet(
    final BuildContext context,
  ) async {
    final result = await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          color: Colors.black87,
          height: 150,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      // height: 70,
                      width: double.infinity,
                      child: Text("Contact Us",
                          textAlign: TextAlign.center,
                          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      // height: 70,
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          openGmailApp();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.email_outlined,color: Colors.white,),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("support@nintriva.com",
                                textAlign: TextAlign.center,
                                style: AppTheme.lightTheme.textTheme.bodyLarge
                                    ?.copyWith(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (result == null) {}
  }
}