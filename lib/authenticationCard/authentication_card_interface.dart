import "package:flutter/material.dart";
import "package:flutter_moshimoshi/entities/tokens.dart";

abstract class AuthenticatorCardInterface {
    Future<Tokens?> getCurrentToken(Map<String, dynamic> parameters);
    Future<Tokens?> refreshAccessToken(String refreshToken);
    Future<void> logout();
}