import 'package:grindly/features/wakatime/summarries/data/models/project_model.dart';
import 'package:grindly/features/wakatime/summarries/domain/entities/project.dart';
import 'package:grindly/features/wakatime/summarries/domain/entities/todays_summarries.dart';

class TodaysSummarriesModel {
  final List<Project> projectsWorkedOnToday;
  final Duration totalTimeWorkedToday;

  const TodaysSummarriesModel({
    required this.projectsWorkedOnToday,
    required this.totalTimeWorkedToday,
  });

  factory TodaysSummarriesModel.fromJson({required Map<String, dynamic> json}) {
    final int hours = json['grand_total']['hours'];
    final int minutes = json['grand_total']['minutes'];
    return TodaysSummarriesModel(
      projectsWorkedOnToday: (json['projects'] as List<dynamic>)
          .map(
            (projectJson) =>
                ProjectModel.fromJson(json: projectJson).toEntity(),
          )
          .toList(),
      totalTimeWorkedToday: Duration(hours: hours, minutes: minutes),
    );
  }

  TodaysSummarries toEntity() {
    return TodaysSummarries(
      projectsWorkedOnToday: projectsWorkedOnToday,
      totalTimeWorkedToday: totalTimeWorkedToday,
    );
  }
}
