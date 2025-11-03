import 'package:flutter/material.dart';

class LeaderProfileWidget extends StatelessWidget {
  final int rank;
  final String imgUrl;
  final String displayName;
  final String duration;
  const LeaderProfileWidget({
    super.key,
    required this.displayName,
    required this.duration,
    required this.imgUrl,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 5.0),
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
          Text(_formatDuration(duration), style: theme.textTheme.titleLarge),
        ],
      ),
    );
  }

  String _formatDuration(String input) {
    final hourRegex = RegExp(
      r'(\d+)\s*(?:h|hr|hrs|hour|hours)',
      caseSensitive: false,
    );
    final minRegex = RegExp(
      r'(\d+)\s*(?:m|min|mins|minute|minutes)',
      caseSensitive: false,
    );

    final hourMatch = hourRegex.firstMatch(input);
    final minMatch = minRegex.firstMatch(input);

    final hours = hourMatch != null ? int.parse(hourMatch.group(1)!) : 0;
    final minutes = minMatch != null ? int.parse(minMatch.group(1)!) : 0;

    final minutesPadded = minutes.toString().padLeft(2, '0');
    return '$hours:$minutesPadded';
  }
}
