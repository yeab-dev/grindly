import 'package:grindly/features/wakatime/stats/data/models/project_model.dart';
import 'package:grindly/features/wakatime/stats/domain/entities/project.dart';

class TodaysStatsModel {
  final List<Project> projectsWorkedOnToday;
  final Duration totalTimeWorkedToday;

  const TodaysStatsModel({
    required this.projectsWorkedOnToday,
    required this.totalTimeWorkedToday,
  });

  factory TodaysStatsModel.fromJson({required Map<String, dynamic> json}) {
    return TodaysStatsModel(
      projectsWorkedOnToday: (json['projects'] as List<dynamic>)
          .map(
            (projectJson) =>
                ProjectModel.fromJson(json: projectJson).toEntity(),
          )
          .toList(),
      totalTimeWorkedToday: json['grandTotal']['digital'],
    );
  }
}
