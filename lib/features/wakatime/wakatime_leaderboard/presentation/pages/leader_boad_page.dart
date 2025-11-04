import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/presentation/cubits/wakatime_leaders_cubit.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/presentation/widgets/leader_profile_widget.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/presentation/widgets/leaderboard_filtering_widget.dart';

class LeaderBoadPage extends StatelessWidget {
  const LeaderBoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: width,
      child: BlocConsumer<WakatimeLeadersCubit, WakatimeLeadersState>(
        listener: (context, state) {
          if (state is WakatimeLeadersFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          if (state is WakatimeLeadersInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WakatimeLeadersSuccess) {
            return Expanded(
              child: Column(
                children: [
                  LeaderboardFilteringWidget(),
                  // SizedBox(height: height * 0.05),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.leaders.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.01,
                          ),
                          child: LeaderProfileWidget(
                            rank: state.leaders[index].rank,
                            imgUrl: state.leaders[index].photoUrl,
                            displayName: state.leaders[index].displayName,
                            duration: state
                                .leaders[index]
                                .totalHoursSpentDuringTheWeek,
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
    );
  }
}
