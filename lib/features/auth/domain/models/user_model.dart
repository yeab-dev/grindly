class UserModel {
  final String? id;
  final String email;
  final String? username;
  final String password;

  const UserModel({
    this.id,
    required this.email,
    this.username,
    required this.password,
  });
}
