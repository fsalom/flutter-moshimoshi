class TokensDTO {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  int expirationTime;

  TokensDTO(this.expirationTime,
      {required this.accessToken,
      required this.refreshToken,
      required this.expiresIn}) {
    var expirationDate = DateTime.now().add(Duration(seconds: expiresIn));
    expirationTime = expirationDate.microsecondsSinceEpoch;
  }
}
