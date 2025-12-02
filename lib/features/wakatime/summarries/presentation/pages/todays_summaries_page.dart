import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/wakatime/summarries/presentation/cubit/wakatime_summaries_cubit.dart';
import 'package:grindly/features/wakatime/summarries/presentation/pages/widgets/project_widget.dart';
import 'package:grindly/features/wakatime/summarries/presentation/pages/widgets/project_widget_in_listview_widget.dart';
import 'package:grindly/features/wakatime/summarries/presentation/pages/widgets/total_time_worked_today_card.dart';

class TodaysSummariesPage extends StatefulWidget {
  const TodaysSummariesPage({super.key});

  @override
  State<TodaysSummariesPage> createState() => _TodaysSummariesPageState();
}

class _TodaysSummariesPageState extends State<TodaysSummariesPage> {
  bool viewProjectsInListView = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<WakatimeSummariesCubit, WakatimeSummariesState>(
          builder: (context, state) {
            if (state is WakatimeSummariesSuccess) {
              return RefreshIndicator(
                onRefresh: () async => await context
                    .read<WakatimeSummariesCubit>()
                    .getTodaysSummary(),
                child: SizedBox(
                  height: height * 0.45,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Center(
                        child: TotalTimeWorkedTodayCard(
                          duration: state.summarries.totalTimeWorkedToday,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is WakatimeSummariesInProgress) {
              return SizedBox(
                height: height * 0.4,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is WakatimeSummariesFailure) {
              return RefreshIndicator(
                onRefresh: () async => await context
                    .read<WakatimeSummariesCubit>()
                    .getTodaysSummary(),
                child: SizedBox(
                  height: height * 0.45,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Center(
                        child: TotalTimeWorkedTodayCard(
                          duration: Duration.zero,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: Padding(
            padding: EdgeInsets.only(right: width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Projects', style: theme.textTheme.headlineSmall),
                IconButton(
                  onPressed: () {
                    setState(() {
                      viewProjectsInListView = !viewProjectsInListView;
                    });
                  },
                  icon: viewProjectsInListView
                      ? Icon(Icons.grid_view)
                      : Icon(Icons.list),
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<WakatimeSummariesCubit, WakatimeSummariesState>(
          builder: (context, state) {
            if (state is WakatimeSummariesSuccess) {
              if (state.summarries.projectsWorkedOnToday.isEmpty) {
                return Center(
                  child: SizedBox(
                    height: height * 0.15,
                    child: Text(
                      'You havent worked on a project today!',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              }
              if (viewProjectsInListView) {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: width * 0.01,
                      mainAxisSpacing: height * 0.01,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: state.summarries.projectsWorkedOnToday.length,
                    itemBuilder: (context, index) {
                      return ProjectWidget(
                        projectName:
                            state.summarries.projectsWorkedOnToday[index].name,
                        timeSpent: state
                            .summarries
                            .projectsWorkedOnToday[index]
                            .timeSpentToday!,
                      );
                    },
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ProjectWidgetInListviewWidget(
                        projectName:
                            state.summarries.projectsWorkedOnToday[index].name,
                        timeSpent: state
                            .summarries
                            .projectsWorkedOnToday[index]
                            .timeSpentToday!,
                      );
                    },
                    itemCount: state.summarries.projectsWorkedOnToday.length,
                  ),
                );
              }
            } else if (state is WakatimeSummariesFailure) {
              return Center(child: Text('couldn\'t read your wakatime data'));
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
