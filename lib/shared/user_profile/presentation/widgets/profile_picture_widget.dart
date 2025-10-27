import 'package:flutter/material.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String imgSource;
  const ProfilePictureWidget({super.key, required this.imgSource});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Center(
      child: Container(
        height: height * 0.13,
        width: height * 0.13,
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.primary,
            width: width * 0.01,
          ),
          shape: BoxShape.circle,
          color: theme.colorScheme.primary,
        ),
        child: CircleAvatar(backgroundImage: NetworkImage(imgSource)),
      ),
    );
  }
}
