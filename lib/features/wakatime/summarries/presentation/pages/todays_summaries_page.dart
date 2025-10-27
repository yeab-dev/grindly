import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/routes.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Summary',
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.tertiary,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<WakatimeSummariesCubit, WakatimeSummariesState>(
            builder: (context, state) {
              if (state is WakatimeSummariesSuccess) {
                return Center(
                  child: TotalTimeWorkedTodayCard(
                    duration: state.summarries.totalTimeWorkedToday,
                  ),
                );
              } else if (state is WakatimeSummariesInProgress) {
                SizedBox(height: height * 0.1);
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
                          projectName: state
                              .summarries
                              .projectsWorkedOnToday[index]
                              .name,
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
                          projectName: state
                              .summarries
                              .projectsWorkedOnToday[index]
                              .name,
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
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
        onTap: (index) {
          if (index == 1) {
            context.go(Routes.profilePage);
          }
        },
        items: [
          BottomNavigationBarItem(
            label: "summary",
            icon: Icon(Icons.auto_graph),
          ),
          BottomNavigationBarItem(label: 'profile', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
