class Token {
  final String value;
  final int expiresIn;
  int expirationTime = 0;

  bool get isValid {
    return DateTime.now().millisecondsSinceEpoch < expirationTime;
  }

  Token(this.value, this.expiresIn, int expirationTimeValue) {
    print("Creating Token instance with value: $value, expiresIn: $expiresIn, expirationTimeValue: $expirationTimeValue");    
    calculateExpirationTime(expirationTimeValue);
    print("es válido: $isValid");
  }

  void calculateExpirationTime(int expirationTimeValue) {
    if (expirationTimeValue == 0) {
      var expirationDate = DateTime.now().add(Duration(seconds: expiresIn));
      expirationTime = expirationDate.millisecondsSinceEpoch;
    } else {
      expirationTime = expirationTimeValue;
    }
  }
}