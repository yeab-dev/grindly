import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/shared/domain/entities/project.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';
import 'package:grindly/shared/user_profile/presentation/cubits/leader_profile/leader_profile_cubit.dart';
import 'package:grindly/shared/user_profile/presentation/widgets/network_and_streak_info_widget.dart';
import 'package:grindly/shared/user_profile/presentation/widgets/profile_picture_widget.dart';
import 'package:grindly/shared/user_profile/presentation/widgets/social_media_widget.dart';
import 'package:grindly/shared/user_profile/presentation/widgets/summary_card.dart';

class LeaderProfilePage extends StatelessWidget {
  final User currentUser;
  const LeaderProfilePage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: BlocConsumer<LeaderProfileCubit, LeaderProfileState>(
        listener: (context, state) {
          if (state is LeaderProfileFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('user: ${state.errorMessage}')),
            );
          }
        },
        builder: (context, state) {
          if (state is LeaderProfileSuccess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfilePictureWidget(imgSource: state.user!.photoUrl!),
                Padding(
                  padding: EdgeInsets.only(top: 18.0, bottom: width * 0.05),
                  child: Center(
                    child: Text(
                      state.user!.displayName,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.03),
                  child: NetworkAndStreakInfoWidget(
                    following: 0,
                    followers: 0,
                    isOwnProfile: false,
                    currentUser: currentUser,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.03),
                  child: Center(
                    child: Text(
                      "\"${state.user!.bio}\"",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                        fontSize: width * 0.045,
                        color: theme.colorScheme.secondary.withAlpha(100),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.05),
                  child: SocialMediaWidget(
                    xLink:
                        state.user!.socialMediaAccounts.any(
                          (account) => account.platformName == "X",
                        )
                        ? state.user!.socialMediaAccounts
                              .firstWhere(
                                (account) => account.platformName == "X",
                              )
                              .url
                        : null,
                    telegramLink:
                        state.user!.socialMediaAccounts.any(
                          (account) => account.platformName == "Telegram",
                        )
                        ? state.user!.socialMediaAccounts
                              .firstWhere(
                                (account) => account.platformName == "Telegram",
                              )
                              .url
                        : null,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.03),
                    child: Text(
                      'Summary',
                      style: theme.textTheme.headlineLarge!.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.03,
                    top: height * 0.01,
                    right: width * 0.03,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SummaryCard(
                            title: state
                                .user!
                                .wakatimeAccount!
                                .bestLanguageWithDuration['name'],
                            description: 'top language',
                            iconImage: SizedBox(
                              width: width * 0.07,
                              child: Image.asset('assets/icons/lang-icon.png'),
                            ),
                          ),
                          SummaryCard(
                            title: formatDuration(
                              state.user!.wakatimeAccount!.totalTime,
                            ),
                            description: 'total time',
                            iconImage: SizedBox(
                              width: width * 0.05,
                              child: Image.asset(
                                'assets/icons/total-time-icon.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SummaryCard(
                              title: state
                                  .user!
                                  .wakatimeAccount!
                                  .bestWeekDayWithDuration['name'],
                              description: 'most active day',
                              iconImage: SizedBox(
                                width: width * 0.058,
                                child: Image.asset(
                                  'assets/icons/active-day-icon.png',
                                ),
                              ),
                            ),
                            SummaryCard(
                              title:
                                  (state
                                              .user!
                                              .wakatimeAccount!
                                              .bestProjectWithDuration['project']
                                          as Project)
                                      .name,
                              description: 'top Project',
                              iconImage: SizedBox(
                                width: width * 0.06,
                                child: Image.asset(
                                  'assets/icons/project-icon.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is LeaderProfileInProgress) {
            return Padding(
              padding: EdgeInsets.only(top: height * 0.4),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return SizedBox.shrink();
        },
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
