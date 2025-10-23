class Project {
  final String name;
  final Duration timeSpentToday;
  final Duration? timeSpentAllTime;

  const Project({
    required this.name,
    required this.timeSpentToday,
    this.timeSpentAllTime,
  });
}
