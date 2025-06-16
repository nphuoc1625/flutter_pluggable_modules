/// Represents an authentication token with its associated data.
class Token {
  /// The access token string.
  final String accessToken;

  /// The refresh token string.
  final String refreshToken;

  /// The expiration timestamp of the access token.
  final DateTime expiresAt;

  /// Creates a new [Token] instance.
  Token({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  /// Creates a [Token] from a JSON map.
  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );
  }

  /// Converts the [Token] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt.toIso8601String(),
    };
  }

  /// Creates a copy of this [Token] with the given fields replaced with new values.
  Token copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
  }) {
    return Token(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Token &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.expiresAt == expiresAt;
  }

  @override
  int get hashCode => Object.hash(accessToken, refreshToken, expiresAt);
}
