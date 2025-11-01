class Leader {
  final String userId;
  final String displayName;
  final int rank;
  final String photoUrl;
  final bool photoPublic;
  final String countryCode;
  final String totalHoursSpentDuringTheWeek;

  const Leader({
    required this.userId,
    required this.displayName,
    required this.rank,
    required this.photoPublic,
    required this.photoUrl,
    required this.countryCode,
    required this.totalHoursSpentDuringTheWeek,
  });
}
