import 'package:flutter/material.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      margin: EdgeInsets.only(left: width * 0.05, bottom: height * 0.03),
      padding: EdgeInsets.only(left: width * 0.03, top: height * 0.01),
      width: width * 0.45,
      height: height * 0.12,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.tertiary.withAlpha(50),
          width: width * 0.005,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: height * 0.024,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 7.0),
                    child: Image.asset('assets/icons/x-icon.png'),
                  ),
                  Text('X', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.03,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      height: height * 0.024,
                      child: Image.asset('assets/icons/telegram-icon.png'),
                    ),
                  ),
                  Text('Telegram', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
