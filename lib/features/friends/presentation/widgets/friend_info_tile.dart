import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/routes.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';
import 'package:grindly/shared/user_profile/presentation/cubits/other_users/other_users_profile_cubit.dart';

class FriendInfoTile extends StatefulWidget {
  final String displayName;
  final String userID;
  final String photoUrl;
  final bool followsThem;
  final Duration totalHours;
  final User currentUser;
  const FriendInfoTile({
    super.key,
    required this.currentUser,
    required this.displayName,
    required this.userID,
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
    return BlocBuilder<OtherUsersProfileCubit, OtherUsersProfileState>(
      builder: (context, state) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (widget.currentUser.uid != widget.userID) {
              context.read<OtherUsersProfileCubit>().getUser(
                grindlyID: widget.userID,
              );
              context.push(
                Routes.otherUsersProfilePage,
                extra: widget.currentUser,
              );
            } else {
              context.push(Routes.profilePage);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: height * 0.03,
                backgroundImage: NetworkImage(widget.photoUrl),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.displayName.length <= 18
                          ? widget.displayName
                          : "${widget.displayName.substring(0, 15)}...",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: height * 0.025,
                            child: Image.asset(
                              'assets/icons/total-time-icon.png',
                            ),
                          ),
                          Text(_formatHoursBucket(widget.totalHours)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              if (widget.currentUser.uid != widget.userID)
                Padding(
                  padding: EdgeInsets.only(right: width * 0.01),
                  child: SizedBox(
                    width: width * 0.25,
                    height: height * 0.045,
                    child: TextButton(
                      onPressed: () {
                        if (followsThem) {
                          context.read<OtherUsersProfileCubit>().unfollow(
                            unfollowingUserID: widget.currentUser.uid,
                            userBeingUnfollowed: widget.userID,
                          );
                        } else {
                          context.read<OtherUsersProfileCubit>().follow(
                            followingUserID: widget.currentUser.uid,
                            followedUserID: widget.userID,
                          );
                        }
                        setState(() {
                          followsThem = !followsThem;
                        });
                      },
                      style: ButtonStyle(
                        side: WidgetStateProperty.all(
                          followsThem
                              ? BorderSide(
                                  color: theme.colorScheme.primary,
                                  width: 1,
                                )
                              : null,
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: followsThem
                            ? WidgetStateProperty.all(theme.colorScheme.surface)
                            : WidgetStateProperty.all(
                                theme.colorScheme.primary,
                              ),
                        foregroundColor: followsThem
                            ? WidgetStateProperty.all(theme.colorScheme.primary)
                            : WidgetStateProperty.all(
                                theme.colorScheme.onPrimary,
                              ),
                      ),
                      child: Text(followsThem ? 'unfollow' : 'follow'),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
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
