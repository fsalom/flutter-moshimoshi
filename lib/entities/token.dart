class Token {
  final String value;
  final int expiresIn;
  int expirationTime = 0;

  bool get isValid {
    return DateTime.now().millisecondsSinceEpoch < expirationTime;
  }

  Token(this.value, this.expiresIn, int expirationTimeValue) {
    calculateExpirationTime(expirationTimeValue);
  }

  void calculateExpirationTime(int expirationTimeValue) {
    if (expirationTimeValue == 0) {
      var expirationDate = DateTime.now().add(Duration(seconds: expiresIn));
      expirationTime = expirationDate.millisecondsSinceEpoch;
    } else {
      expirationTime = expirationTimeValue;
    }
  }

  @override
  String toString() => 'Token(value: $value, expiresIn: $expiresIn, expirationTime: $expirationTime)';
}
