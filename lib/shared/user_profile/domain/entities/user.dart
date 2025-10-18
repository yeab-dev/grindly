class User {
  final String uid;
  final String email;
  final String displayName;
  final String? username;
  final String? photoUrl;
  final DateTime createdAt;

  const User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.createdAt,
    this.username,
    this.photoUrl,
  });
}
