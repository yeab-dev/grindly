import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/wakatime/summarries/presentation/cubit/wakatime_summaries_cubit.dart';
import 'package:grindly/features/wakatime/summarries/presentation/pages/widgets/project_widget.dart';
import 'package:grindly/features/wakatime/summarries/presentation/pages/widgets/total_time_worked_today_card.dart';

class TodaysSummariesPage extends StatelessWidget {
  const TodaysSummariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Summary',
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.tertiary,
          ),
        ),
      ),
      body: BlocConsumer<WakatimeSummariesCubit, WakatimeSummariesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is WakatimeSummariesSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: TotalTimeWorkedTodayCard(
                    duration: state.summarries.totalTimeWorkedToday,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Text('Projects', style: theme.textTheme.headlineSmall),
                ),

                Expanded(
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
                            .timeSpentToday,
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        items: [
          BottomNavigationBarItem(
            label: "summary",
            icon: Icon(Icons.auto_graph),
          ),
          BottomNavigationBarItem(
            label: 'what',
            icon: Icon(Icons.psychology_alt_rounded),
          ),
        ],
      ),
    );
  }
}
