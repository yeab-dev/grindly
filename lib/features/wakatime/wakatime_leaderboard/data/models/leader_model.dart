class LeaderModel {
  final String userId;
  final String displayName;
  final int rank;
  final String photoUrl;
  final bool photoPublic;
  final String countryCode;
  final String totalHoursSpentDuringTheWeek;

  const LeaderModel({
    required this.userId,
    required this.displayName,
    required this.rank,
    required this.photoPublic,
    required this.photoUrl,
    required this.countryCode,
    required this.totalHoursSpentDuringTheWeek,
  });

  factory LeaderModel.fromJson(Map<String, dynamic> json) {
    return LeaderModel(
      userId: json['user']['id'],
      displayName: json['user']['display_name'],
      rank: json['rank'],
      photoPublic: json['user']['photo_public'],
      photoUrl: json['user']['photo'],
      countryCode: json['user']['city']['country_code'],
      totalHoursSpentDuringTheWeek:
          json['running_total']['human_readable_total'],
    );
  }
}
