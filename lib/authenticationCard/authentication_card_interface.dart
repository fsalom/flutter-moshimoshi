import "package:flutter_moshimoshi/entities/endpoint.dart";
import "package:flutter_moshimoshi/entities/tokens.dart";

abstract interface class AuthenticatorCardInterface {
  Future<Tokens?> getCurrentToken({
    required Map<String, dynamic> parameters,
    Endpoint? endpoint,
  });
  Future<Tokens?> refreshAccessToken(String refreshToken);
  Future<void> logout();
}
