import 'package:flutter/material.dart';

class NetworkAndStreakInfoWidget extends StatelessWidget {
  const NetworkAndStreakInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.03, bottom: height * 0.04),
        child: Container(
          width: width * 0.9,
          height: height * 0.16,
          padding: EdgeInsets.only(top: height * 0.007, left: width * 0.03),
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.tertiary.withAlpha(50),
              width: width * 0.005,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '0',
                        style: theme.textTheme.headlineLarge!.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Following'),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.02,
                    ),
                    height: height * 0.05,
                    color: theme.colorScheme.secondaryContainer,
                    child: SizedBox(width: width * 0.005),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '0',
                        style: theme.textTheme.headlineLarge!.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Followers'),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(bottom: height * 0.01),
                child: Text(
                  'commit early, commit often',
                  style: TextStyle(fontSize: 19),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
