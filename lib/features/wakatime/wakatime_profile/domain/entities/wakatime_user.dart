class WakatimeUser {
  final String photoUrl;
  final Map<String, dynamic> bestProjectWithDuration;
  final Map<String, dynamic> bestWeekDayWithDuration;
  final Map<String, dynamic> bestLanguageWithDuration;
  final Duration totalTime;
  const WakatimeUser({
    required this.photoUrl,
    required this.bestLanguageWithDuration,
    required this.bestProjectWithDuration,
    required this.bestWeekDayWithDuration,
    required this.totalTime,
  });
}
