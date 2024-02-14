import "package:flutter_moshimoshi/entities/tokens.dart";

abstract class AuthenticatorCardInterface {
    Future<Tokens> getCurrentToken();
    Future<Tokens> refreshAccessToken(String refreshToken);
    Future<void> logout();
}