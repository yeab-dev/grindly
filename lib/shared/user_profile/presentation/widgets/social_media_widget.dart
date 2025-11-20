import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaWidget extends StatelessWidget {
  final String? xLink;
  final String? telegramLink;
  const SocialMediaWidget({super.key, this.xLink, this.telegramLink});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.04,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: const CircleBorder(),
              minimumSize: Size(height * 0.05, height * 0.05),
            ),
            onPressed: () async {
              if (xLink == null) {
              } else {
                final uri = Uri.parse(xLink!);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            child: Image.asset('assets/icons/x-icon.png'),
          ),
        ),
        SizedBox(
          height: height * 0.04,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.all(8),
              // optional: enforce a minimum size for a consistent circular hit area
              minimumSize: Size(height * 0.05, height * 0.05),
            ),
            onPressed: () async {
              if (telegramLink == null) {
              } else {
                final uri = Uri.parse(telegramLink!);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            child: Image.asset('assets/icons/telegram-icon.png'),
          ),
        ),
      ],
    );
  }
}
