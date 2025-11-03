import 'package:flutter/material.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/presentation/widgets/leaderboard_filtering_widget.dart';

class LeaderBoadPage extends StatelessWidget {
  const LeaderBoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: Column(children: [LeaderboardFilteringWidget()]),
    );
  }
}
