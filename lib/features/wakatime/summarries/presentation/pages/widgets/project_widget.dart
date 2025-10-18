import 'package:flutter/material.dart';

class ProjectWidget extends StatelessWidget {
  final String projectName;
  final Duration timeSpent;
  const ProjectWidget({
    super.key,
    required this.projectName,
    required this.timeSpent,
  });

  @override
  Widget build(BuildContext context) {
    final duration = timeSpent.toString().split(':');
    final hours = duration[0];
    final minutes = duration[1];

    final theme = Theme.of(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.all(width * 0.06),
      height: height * 0.15,
      width: width * 0.37,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary,
          width: width * 0.01,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.055),
              child: Text(projectName, style: theme.textTheme.titleLarge),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              bottom: height * 0.005,
              right: width * 0.015,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.timer_outlined, size: width * 0.05),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.008),
                  child: Text("$hours $minutes"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
