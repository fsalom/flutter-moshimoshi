import 'package:flutter_moshimoshi/entities/token.dart';

class Tokens {
  Token accessToken;
  Token refreshToken;

  Tokens({required this.accessToken, required this.refreshToken}) {
    accessToken = accessToken;
    print("AccessToken: $accessToken");
    refreshToken = refreshToken;
    print("RefreshToken: $refreshToken");
  }
}