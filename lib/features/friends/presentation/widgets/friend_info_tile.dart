import 'package:flutter/material.dart';

class FriendInfoTile extends StatefulWidget {
  final String displayName;
  final String photoUrl;
  final bool followsThem;
  final Duration totalHours;
  const FriendInfoTile({
    super.key,
    required this.displayName,
    required this.photoUrl,
    required this.followsThem,
    required this.totalHours,
  });

  @override
  State<FriendInfoTile> createState() => _FriendInfoTileState();
}

class _FriendInfoTileState extends State<FriendInfoTile> {
  late bool followsThem;
  @override
  void initState() {
    followsThem = widget.followsThem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: height * 0.03,
          backgroundImage: NetworkImage(widget.photoUrl),
        ),
        SizedBox(
          height: height * 0.065,
          child: Padding(
            padding: EdgeInsets.only(left: height * 0.015),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.5,
                  child: Text(
                    widget.displayName.length <= 18
                        ? widget.displayName
                        : "${widget.displayName.substring(0, 15)}...",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: height * 0.025,
                        child: Image.asset('assets/icons/total-time-icon.png'),
                      ),
                      Text(_formatHoursBucket(widget.totalHours)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: width * 0.01),
          child: SizedBox(
            width: width * 0.25,
            height: height * 0.045,
            child: TextButton(
              onPressed: () {
                setState(() {
                  followsThem = !followsThem;
                });
              },
              style: ButtonStyle(
                side: WidgetStateProperty.all(
                  followsThem
                      ? BorderSide(color: theme.colorScheme.primary, width: 1)
                      : null,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: followsThem
                    ? WidgetStateProperty.all(theme.colorScheme.surface)
                    : WidgetStateProperty.all(theme.colorScheme.primary),
                foregroundColor: followsThem
                    ? WidgetStateProperty.all(theme.colorScheme.primary)
                    : WidgetStateProperty.all(theme.colorScheme.onPrimary),
              ),
              child: Text(followsThem ? 'unfollow' : 'follow'),
            ),
          ),
        ),
      ],
    );
  }

  String _formatHoursBucket(Duration duration) {
    final hours = duration.inHours;
    if (hours <= 49) return '>50';
    final bucket = (hours ~/ 50) * 50;
    final adjusted = bucket == 0 ? 50 : bucket;
    return '$adjusted+';
  }
}
