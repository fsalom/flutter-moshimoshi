class DetailException implements Exception {
  final int statusCode;
  final String? message;

  DetailException(this.statusCode, [this.message]);

  @override
  String toString() {
    return message != null ? 'DetailException (code $statusCode): $message' : 'DetailException (code $statusCode)';
  }
}
