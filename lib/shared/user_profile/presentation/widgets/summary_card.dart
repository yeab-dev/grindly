import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;
  const SummaryCard({
    super.key,
    required this.title,
    required this.description,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      height: height * 0.08,
      width: width * 0.4,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.tertiary.withAlpha(80),
          width: 2.8,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                  color: theme.colorScheme.primary,
                  size: width * 0.07,
                ),
                SizedBox(width: width * 0.02),
                Text(title, style: theme.textTheme.titleLarge),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.02),
              child: Text(
                description,
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
