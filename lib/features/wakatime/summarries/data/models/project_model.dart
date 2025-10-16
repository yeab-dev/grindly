import 'package:grindly/features/wakatime/stats/domain/entities/project.dart';

class ProjectModel {
  final String name;
  final Duration timeSpentToday;

  const ProjectModel({required this.name, required this.timeSpentToday});

  factory ProjectModel.fromJson({required Map<String, dynamic> json}) {
    return ProjectModel(name: json['name'], timeSpentToday: json['digital']);
  }

  Project toEntity() {
    return Project(name: name, timeSpentToday: timeSpentToday);
  }
}
