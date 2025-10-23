class Project {
  final String name;
  final Duration? timeSpentToday;
  final Duration? timeSpentAllTime;

  const Project({
    required this.name,
    this.timeSpentToday,
    this.timeSpentAllTime,
  });
}
