import "package:flutter_moshimoshi/entities/Token.dart";

class Tokens {
  late Token acccesToken;
  late Token refreshToken;

  init(Token accessToken, Token refreshToken) {
    acccesToken = accessToken;
    refreshToken = refreshToken;
  }
}