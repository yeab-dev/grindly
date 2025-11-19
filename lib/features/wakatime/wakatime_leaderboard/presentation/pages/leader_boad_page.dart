import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/entities/leader.dart';
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
                final List<Leader> leaders;
                if (state.index == 0) {
                  leaders = state.globalLeaders;
                } else if (state.index == 1) {
                  leaders = state.countryLeaders;
                } else {
                  leaders = state.grindlyLeaders;
                }
                scrollTargetIndex = leaders.indexWhere(
                  (leader) =>
                      leader.wakatimeID ==
                      widget.grindlyUser.wakatimeAccount?.id,
                );
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (scrollTargetIndex != null && scrollTargetIndex! >= 0) {
                    _scrollToIndex(scrollTargetIndex!, height * 0.077);
                    if (state.index != 2) {
                      context.read<WakatimeLeadersCubit>().saveGrindlyLeader(
                        leader: leaders[scrollTargetIndex!],
                      );
                    }
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
                              : state.index == 1
                              ? state.countryLeaders.length
                              : state.grindlyLeaders.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.01,
                              ),
                              child: LeaderProfileWidget(
                                wakatimeId: state.index == 0
                                    ? state.globalLeaders[index].wakatimeID
                                    : state.index == 1
                                    ? state.countryLeaders[index].wakatimeID
                                    : state.grindlyLeaders[index].wakatimeID,
                                rank: state.index == 0
                                    ? state.globalLeaders[index].rank
                                    : state.index == 1
                                    ? state.countryLeaders[index].rank
                                    : index + 1,
                                imgUrl: state.index == 0
                                    ? state.globalLeaders[index].photoUrl
                                    : state.index == 1
                                    ? state.countryLeaders[index].photoUrl
                                    : state.grindlyLeaders[index].photoUrl,
                                displayName: state.index == 0
                                    ? state.globalLeaders[index].displayName
                                    : state.index == 1
                                    ? state.countryLeaders[index].displayName
                                    : state.grindlyLeaders[index].displayName,
                                durationInSeconds: state.index == 0
                                    ? state
                                          .globalLeaders[index]
                                          .totalHoursInSeconds
                                    : state.index == 1
                                    ? state
                                          .countryLeaders[index]
                                          .totalHoursInSeconds
                                    : state
                                          .grindlyLeaders[index]
                                          .totalHoursInSeconds,
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
