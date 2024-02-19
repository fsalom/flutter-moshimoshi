class Token {
  late String value;
  late int expiresIn;
  late final int expirationTime;
  bool get isValid {
    return DateTime.now().millisecondsSinceEpoch < expirationTime;
  }

  Token(String value, int expiresIn, [int expirationTime = 0]) {
    value = value;
    expiresIn = expiresIn;
    if (expirationTime == 0) {
      var expirationDate = DateTime.now().add(Duration(seconds: expiresIn));
      expirationTime = expirationDate.microsecondsSinceEpoch;
    }
  }
}