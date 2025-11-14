import 'package:flutter/material.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';

class LeaderProfileWidget extends StatelessWidget {
  final int rank;
  final String imgUrl;
  final String displayName;
  final int durationInSeconds;
  final String wakatimeId;
  final User currentUser;
  const LeaderProfileWidget({
    super.key,
    required this.wakatimeId,
    required this.currentUser,
    required this.displayName,
    required this.durationInSeconds,
    required this.imgUrl,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      height: height * 0.065,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: wakatimeId == currentUser.wakatimeAccount?.id
            ? theme.colorScheme.primaryContainer
            : null,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Text('$rank', style: theme.textTheme.titleMedium),
            ),
          ),
          CircleAvatar(
            radius: width * 0.06,
            backgroundImage: NetworkImage(imgUrl),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                displayName,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
            ),
          ),
          Text(
            _formatDuration(durationInSeconds),
            style: theme.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  String _formatDuration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final remainingSeconds = totalSeconds % 3600;
    final minutes = remainingSeconds ~/ 60;
    final minutesPadded = minutes.toString().padLeft(2, '0');
    return '$hours:$minutesPadded';
  }
}
