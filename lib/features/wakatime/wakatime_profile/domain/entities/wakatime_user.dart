class WakatimeUser {
  final String photoUrl;
  final Duration bestProjectByDuration;
  final Duration bestWeekDayByDuration;
  final Duration bestLanguageByDuration;
  final Duration totalTime;
  const WakatimeUser({
    required this.photoUrl,
    required this.bestLanguageByDuration,
    required this.bestProjectByDuration,
    required this.bestWeekDayByDuration,
    required this.totalTime,
  });
}
