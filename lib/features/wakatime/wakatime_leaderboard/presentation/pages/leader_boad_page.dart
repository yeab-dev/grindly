import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/entities/grindly_leader.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/presentation/cubits/wakatime_leaders_cubit.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/presentation/widgets/leader_profile_widget.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/presentation/widgets/leaderboard_filtering_widget.dart';
import 'package:grindly/shared/user_profile/domain/entities/user.dart';

class LeaderBoadPage extends StatefulWidget {
  final User grindlyUser;
  const LeaderBoadPage({super.key, required this.grindlyUser});

  @override
  State<LeaderBoadPage> createState() => _LeaderBoadPageState();
}

class _LeaderBoadPageState extends State<LeaderBoadPage> {
  final ScrollController scrollController = ScrollController();
  int? scrollTargetIndex;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          BlocConsumer<WakatimeLeadersCubit, WakatimeLeadersState>(
            listener: (context, state) {
              if (state is WakatimeLeadersFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            builder: (context, state) {
              if (state is WakatimeLeadersInProgress) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Center(child: CircularProgressIndicator())],
                  ),
                );
              } else if (state is WakatimeLeadersSuccess) {
                final leaders = state.index == 0
                    ? state.globalLeaders
                    : state.countryLeaders;
                scrollTargetIndex = leaders.indexWhere(
                  (leader) =>
                      leader.userId == widget.grindlyUser.wakatimeAccount?.id,
                );
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (scrollTargetIndex != null && scrollTargetIndex! >= 0) {
                    _scrollToIndex(scrollTargetIndex!, height * 0.077);
                    context.read<WakatimeLeadersCubit>().saveLeader(
                      leader: GrindlyLeader(
                        grindlyId: leaders[scrollTargetIndex!].userId,
                        displayName: leaders[scrollTargetIndex!].displayName,
                        photoUrl: leaders[scrollTargetIndex!].photoUrl,
                        timeInSeconds:
                            leaders[scrollTargetIndex!].totalHourInSeconds,
                        country: leaders[scrollTargetIndex!].country,
                      ),
                    );
                  }
                });
                return Expanded(
                  child: Column(
                    children: [
                      LeaderboardFilteringWidget(lastFilter: state.index),
                      // SizedBox(height: height * 0.05),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: state.index == 0
                              ? state.globalLeaders.length
                              : state.countryLeaders.length,
                          itemBuilder: (context, index) {
                            if (state.index == 0 &&
                                state.globalLeaders[index].userId ==
                                    widget.grindlyUser.wakatimeAccount?.id) {
                              scrollTargetIndex = index;
                            }

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.01,
                              ),
                              child: LeaderProfileWidget(
                                wakatimeId: state.index == 0
                                    ? state.globalLeaders[index].userId
                                    : state.countryLeaders[index].userId,
                                rank: state.index == 0
                                    ? state.globalLeaders[index].rank
                                    : state.countryLeaders[index].rank,
                                imgUrl: state.index == 0
                                    ? state.globalLeaders[index].photoUrl
                                    : state.countryLeaders[index].photoUrl,
                                displayName: state.index == 0
                                    ? state.globalLeaders[index].displayName
                                    : state.countryLeaders[index].displayName,
                                durationInSeconds: state.index == 0
                                    ? state
                                          .globalLeaders[index]
                                          .totalHourInSeconds
                                    : state
                                          .countryLeaders[index]
                                          .totalHourInSeconds,
                                currentUser: widget.grindlyUser,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  void _scrollToIndex(int index, double itemHeight) {
    final offset = itemHeight * index;
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
