class WakatimeAuthToken {
  final String accessToken;
  final String refreshToken;
  final String? tokenType;
  final DateTime expiresAt;
  final int? expiresIn;
  final String? scope;
  final String? uid;

  const WakatimeAuthToken({
    required this.accessToken,
    required this.refreshToken,
    this.tokenType,
    required this.expiresAt,
    this.expiresIn,
    this.scope,
    this.uid,
  });
}
