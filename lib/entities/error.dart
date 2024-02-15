
class AuthorizationFailed extends Error implements UnsupportedError {
  final String? message;
  AuthorizationFailed([this.message]);
  String toString() {
    var message = this.message;
    return (message != null)
        ? "AuthorizationFailed: $message"
        : "AuthorizationFailed";
  }
}