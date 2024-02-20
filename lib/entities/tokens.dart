import "package:flutter_moshimoshi/entities/token.dart";

class Tokens {
  late Token acccesToken;
  late Token refreshToken;

  Tokens({required  Token accessToken, required Token refreshToken}) {
    acccesToken = accessToken;
    refreshToken = refreshToken;
  }
}