import 'package:flutter_moshimoshi/core/utils/logs/hybrid_logger_wrapper.dart';

class Token {
  final String value;
  final int expiresIn;
  int expirationTime = 0;

  bool get isValid {
    return DateTime.now().millisecondsSinceEpoch < expirationTime;
  }

  Token(this.value, this.expiresIn, int expirationTimeValue) {
    calculateExpirationTime(expirationTimeValue);
    HybridLoggerWrapper().logger.info(
        "Creating Token instance with value: $value, expiresIn: $expiresIn, expirationTimeValue: $expirationTimeValue, Token is valid: $isValid");
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
  String toString() =>
      'Token(value: $value, expiresIn: $expiresIn, expirationTime: $expirationTime)';
}
