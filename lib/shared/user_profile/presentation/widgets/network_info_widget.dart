import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/routes.dart';
import 'package:grindly/features/friends/presentation/cubit/friends_cubit.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';
import 'package:grindly/shared/user_profile/presentation/cubits/other_users/other_users_profile_cubit.dart';

class NetworkInfoWidget extends StatefulWidget {
  final int following;
  final int followers;
  final bool isOwnProfile;
  final User currentUser;
  final bool followsThem;
  const NetworkInfoWidget({
    super.key,
    required this.following,
    required this.followers,
    required this.isOwnProfile,
    required this.currentUser,
    required this.followsThem,
  });

  @override
  State<NetworkInfoWidget> createState() => _NetworkInfoWidgetState();
}

class _NetworkInfoWidgetState extends State<NetworkInfoWidget> {
  late bool followsThem;
  @override
  void initState() {
    followsThem = widget.followsThem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocConsumer<OtherUsersProfileCubit, OtherUsersProfileState>(
      listener: (context, state) {
        if (state.user != null && state is OtherUsersProfileFailure) {
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(followsThem? )))
        }
      },
      builder: (context, state) {
        return Center(
          child: Container(
            width: width * 0.9,
            margin: EdgeInsets.only(top: height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<FriendsCubit, FriendsState>(
                      builder: (context, friendsState) {
                        // TODO: implement listener
                        return GestureDetector(
                          onTap: () {
                            context.read<FriendsCubit>().getUserNetwork(
                              userId: state.user?.uid ?? widget.currentUser.uid,
                            );
                            context.push(Routes.friendsListPage);
                          },
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width * 0.2,
                                    child: Text(
                                      '${widget.following}',
                                      style: theme.textTheme.headlineLarge!
                                          .copyWith(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Text('Following'),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.05,
                                  vertical: height * 0.02,
                                ),
                                height: height * 0.05,
                                color: theme.colorScheme.secondaryContainer,
                                child: SizedBox(width: width * 0.005),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width * 0.2,
                                    child: Text(
                                      '${widget.followers}',
                                      style: theme.textTheme.headlineLarge!
                                          .copyWith(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Text('Followers'),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: height * 0.02,
                      ),
                      height: height * 0.05,
                      color: theme.colorScheme.secondaryContainer,
                      child: SizedBox(width: width * 0.005),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatDuration(
                            widget.isOwnProfile
                                ? widget.currentUser.wakatimeAccount!.totalTime
                                : state.user!.wakatimeAccount!.totalTime,
                          ),
                          style: theme.textTheme.headlineLarge!.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Total hours'),
                      ],
                    ),
                  ],
                ),
                if (!widget.isOwnProfile)
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: height * 0.053,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              foregroundColor: followsThem
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onPrimary,
                              backgroundColor: followsThem
                                  ? theme.colorScheme.surface
                                  : theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                side: followsThem
                                    ? BorderSide(
                                        color: theme.colorScheme.primary,
                                      )
                                    : BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              if (followsThem) {
                                context.read<OtherUsersProfileCubit>().unfollow(
                                  unfollowingUserID: widget.currentUser.uid,
                                  userBeingUnfollowed: state.user!.uid,
                                );
                              } else {
                                context.read<OtherUsersProfileCubit>().follow(
                                  followingUserID: widget.currentUser.uid,
                                  followedUserID: state.user!.uid,
                                );
                              }
                              setState(() {
                                followsThem = !followsThem;
                              });
                            },
                            child: Text(followsThem ? "Unfollow" : "Follow"),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String formatDuration(Duration duration) {
    final durationList = duration.toString().split(':');
    final int hours = int.parse(durationList[0]);
    return "$hours";
  }
}
