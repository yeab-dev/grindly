import 'package:grindly/features/wakatime/stats/domain/entities/project.dart';

class TodaysSummarries {
  final List<Project> projectsWorkedOnToday;
  final Duration totalTimeWorkedToday;

  const TodaysSummarries({
    required this.projectsWorkedOnToday,
    required this.totalTimeWorkedToday,
  });
}
