// File created by
// Lung Razvan <long1eu>
// on 16/09/2018

import 'package:firebase_common/src/annotations.dart';

/// Result object that contains a Firebase Auth ID Token. */
@publicApi
class GetTokenResult {
  static const String _expirationTimestamp = 'exp';
  static const String _authTimestamp = 'auth_time';
  static const String _issuedAtTimestamp = 'iat';
  static const String _firebaseKey = 'firebase';
  static const String _signInProvider = 'sign_in_provider';

  /// Firebase Auth ID Token. Useful for authenticating calls against your own
  /// backend. Verify the integrity and validity of the token in your server
  /// either by using our server SDKs or following the documentation.
  @publicApi
  final String token;

  /// Returns the entire payload claims of the ID token including the standard
  /// reserved claims as well as the custom claims (set by developer via
  /// Admin SDK). Developers should verify the ID token and parse claims from
  /// its payload on the backend and never trust this value on the client.
  /// Returns an empty map if no claims are present.
  @publicApi
  final Map<String, dynamic> claims;

  /// Token represents the {@link String} access token.
  @keepForSdk
  const GetTokenResult(this.token, [this.claims = const <String, dynamic>{}]);

  /// Returns the time at which this ID token will expire
  @publicApi
  DateTime get expirationTimestamp =>
      _getTimeFromClaimsSafely(_expirationTimestamp);

  /// Returns the authentication timestamp. This is the time the user
  /// authenticated (signed in) and not the time the token was refreshed.
  @publicApi
  DateTime get authTimestamp => _getTimeFromClaimsSafely(_authTimestamp);

  /// Returns the issued at timestamp. This is the time the ID token was last
  /// refreshed and not the authentication timestamp.
  @publicApi
  DateTime get issuedAtTimestamp =>
      _getTimeFromClaimsSafely(_issuedAtTimestamp);

  /// Returns the sign-in provider through which the ID token was obtained
  /// (anonymous, custom, phone, password, etc). Note, this does not map to
  /// provider IDs. For example, anonymous and custom authentications are not
  /// considered providers. We chose the name here to map the name used in the
  /// ID token.
  @publicApi
  String get signInProvider {
    // Sign in provider lives inside the 'firebase' element of the JSON
    final Map<String, dynamic> firebaseElem = claims[_firebaseKey];
    if (firebaseElem != null) {
      return firebaseElem[_signInProvider] as String;
    }
    return null;
  }

  DateTime _getTimeFromClaimsSafely(String key) {
    final int milliseconds = (claims[key] as int) ?? 0;
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetTokenResult &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          claims == other.claims;

  @override
  int get hashCode => token.hashCode ^ claims.hashCode;
}
