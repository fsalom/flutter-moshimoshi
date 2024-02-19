import "package:flutter_moshimoshi/entities/token.dart";

class Tokens {
  late Token acccesToken;
  late Token refreshToken;

  Tokens(Token accessToken, Token refreshToken) {
    acccesToken = accessToken;
    refreshToken = refreshToken;
  }
}