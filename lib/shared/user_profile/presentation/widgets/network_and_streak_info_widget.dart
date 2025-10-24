import 'package:flutter/material.dart';

class NetworkAndStreakInfoWidget extends StatelessWidget {
  const NetworkAndStreakInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.05,
        top: height * 0.03,
        bottom: height * 0.08,
      ),
      child: Row(
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
            margin: EdgeInsets.symmetric(horizontal: width * 0.05),
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.05),
            height: height * 0.05,
            color: theme.colorScheme.secondaryContainer,
            child: SizedBox(width: width * 0.005),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '15',
                style: theme.textTheme.headlineLarge!.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Current Streak'),
            ],
          ),
        ],
      ),
    );
  }
}
