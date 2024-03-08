
class AuthorizationFailed extends Error implements UnsupportedError {
  @override
  final String? message;
  AuthorizationFailed([this.message]);
  @override
  String toString() {
    var message = this.message;
    return (message != null)
        ? "AuthorizationFailed: $message"
        : "AuthorizationFailed";
  }
}