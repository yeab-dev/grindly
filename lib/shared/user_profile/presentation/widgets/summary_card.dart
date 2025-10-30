import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget iconImage;
  const SummaryCard({
    super.key,
    required this.title,
    required this.description,
    required this.iconImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      height: height * 0.08,
      width: width * 0.45,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.tertiary.withAlpha(50),
          width: 2.8,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.01),
              child: Row(
                children: [
                  iconImage,
                  SizedBox(width: width * 0.02),
                  SizedBox(
                    width: width * 0.33,
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.02),
              child: Text(
                description,
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
