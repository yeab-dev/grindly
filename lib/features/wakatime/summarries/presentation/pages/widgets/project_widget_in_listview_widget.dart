import 'package:flutter/material.dart';

class ProjectWidgetInListviewWidget extends StatelessWidget {
  final String projectName;
  final Duration timeSpent;
  const ProjectWidgetInListviewWidget({
    super.key,
    required this.projectName,
    required this.timeSpent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        margin: EdgeInsets.symmetric(vertical: height * 0.02),
        height: height * 0.09,
        width: width * 0.9,
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer.withAlpha(80),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              projectName,
              style: theme.textTheme.headlineSmall!.copyWith(fontSize: 20),
            ),

            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5),
                  height: height * 0.02,
                  child: Image.asset('assets/icons/total-time-icon.png'),
                ),
                Text(
                  formatDuration(timeSpent),
                  style: theme.textTheme.headlineSmall!.copyWith(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    final durationList = duration.toString().split(':');
    final int hours = int.parse(durationList[0]);
    final int minutes = int.parse(durationList[1]);
    return "$hours hrs $minutes min";
  }
}
