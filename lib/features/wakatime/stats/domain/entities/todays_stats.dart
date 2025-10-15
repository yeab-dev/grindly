import 'package:grindly/features/wakatime/stats/domain/entities/project.dart';

class TodaysStats {
  final List<Project> projectsWorkedOnToday;
  final Duration totalTimeWorkedToday;

  const TodaysStats({
    required this.projectsWorkedOnToday,
    required this.totalTimeWorkedToday,
  });
}
