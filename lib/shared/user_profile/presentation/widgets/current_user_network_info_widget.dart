import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/routes.dart';
import 'package:grindly/features/friends/presentation/cubit/friends_cubit.dart';
import 'package:grindly/shared/user_profile/presentation/cubits/user_profile/user_profile_cubit.dart';

class CurrentUserNetworkInfoWidget extends StatefulWidget {
  final int following;
  final int followers;
  const CurrentUserNetworkInfoWidget({
    super.key,
    required this.following,
    required this.followers,
  });

  @override
  State<CurrentUserNetworkInfoWidget> createState() =>
      _CurrentUserNetworkInfoWidgetState();
}

class _CurrentUserNetworkInfoWidgetState
    extends State<CurrentUserNetworkInfoWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocConsumer<UserProfileCubit, UserProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserProfileSuccess) {
          return Center(
            child: Container(
              width: width * 0.9,
              margin: EdgeInsets.only(top: height * 0.02),
              child: Row(
                mainAxisAlignment: state.user.wakatimeAccount != null
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<FriendsCubit, FriendsState>(
                    builder: (context, friendsState) {
                      // TODO: implement listener

                      return GestureDetector(
                        onTap: () {
                          context.read<FriendsCubit>().getUserNetwork(
                            userId: state.user.uid,
                          );
                          context.push(
                            Routes.friendsListPage,
                            extra: state.user,
                          );
                        },
                        child: Row(
                          children: [
                            Column(
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
                  if (state.user.wakatimeAccount != null)
                    Column(
                      children: [
                        Text(
                          formatDuration(state.user.wakatimeAccount!.totalTime),
                          style: theme.textTheme.headlineLarge!.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Total hours'),
                      ],
                    ),
                  if (state.user.wakatimeAccount == null)
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Text(
                              "0",
                              style: theme.textTheme.headlineLarge!.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                message: "Couldn't read your WakaTime account",
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                textStyle: const TextStyle(color: Colors.white),
                                child: const Icon(
                                  Icons.warning,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Text('Total hours'),
                      ],
                    ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  String formatDuration(Duration duration) {
    final durationList = duration.toString().split(':');
    final int hours = int.parse(durationList[0]);
    return "$hours";
  }
}
