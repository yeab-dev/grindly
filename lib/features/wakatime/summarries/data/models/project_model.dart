import 'package:grindly/features/wakatime/summarries/domain/entities/project.dart';

class ProjectModel {
  final String name;
  final Duration timeSpentToday;

  const ProjectModel({required this.name, required this.timeSpentToday});

  factory ProjectModel.fromJson({required Map<String, dynamic> json}) {
    final int hours = json['hours'];
    final int minutes = json['minutes'];
    return ProjectModel(
      name: json['name'],
      timeSpentToday: Duration(hours: hours, minutes: minutes),
    );
  }

  Project toEntity() {
    return Project(name: name, timeSpentToday: timeSpentToday);
  }
}
