import 'package:grindly/shared/domain/repositories/entities/project.dart';

class WakatimeUser {
  final String photoUrl;
  final Map<Project, Duration> projectsWithHoursSpent;
  final Map<int, Duration> weekdaysWithHoursSpent;
  final Duration totalTime;
  const WakatimeUser({
    required this.photoUrl,
    required this.projectsWithHoursSpent,
    required this.weekdaysWithHoursSpent,
    required this.totalTime,
  });
}
