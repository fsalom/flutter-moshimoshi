class Token {
  late String value;
  late int expiresIn;
  late final int expirationTime;
  bool get isValid {
    return DateTime.now().millisecondsSinceEpoch < expirationTime;
  }

  Token(String value, int expiresIn, int expirationTime) {
    value = value;
    expiresIn = expiresIn;
    expirationTime = expirationTime;
  }
}