import "package:flutter_moshimoshi/entities/Token.dart";

class Tokens {
  late Token acccesToken;
  late Token refreshToken;

  Tokens(Token accessToken, Token refreshToken) {
    acccesToken = accessToken;
    refreshToken = refreshToken;
  }
}