import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';
import 'package:grindly/shared/user_profile/presentation/cubits/leader_profile/leader_profile_cubit.dart';

class NetworkAndStreakInfoWidget extends StatelessWidget {
  final int following;
  final int followers;
  final bool isOwnProfile;
  final User currentUser;
  const NetworkAndStreakInfoWidget({
    super.key,
    required this.following,
    required this.followers,
    required this.isOwnProfile,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<LeaderProfileCubit, LeaderProfileState>(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$following',
                          style: theme.textTheme.headlineLarge!.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
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
                        Text(
                          '$followers',
                          style: theme.textTheme.headlineLarge!.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Followers'),
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
                        Text(
                          '938',
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
                if (!isOwnProfile)
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: height * 0.053,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: theme.colorScheme.onPrimary,
                              backgroundColor: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              context.read<LeaderProfileCubit>().follow(
                                followingUserID: currentUser.uid,
                                followedUserID: state.user!.uid,
                              );
                            },
                            child: Text("Follow"),
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
}
