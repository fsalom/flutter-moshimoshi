import 'package:flutter_moshimoshi/authenticationCard/authentication_card_interface.dart';
import 'package:flutter_moshimoshi/entities/tokens.dart';

class PasswordAuthenticationCard implements AuthenticatorCardInterface {
  @override
  Tokens getCurrentToken() {
    // TODO: implement getCurrentToken
    throw UnimplementedError();
  }

  @override
  void logout() {
    // TODO: implement logout
  }

  @override
  Tokens refreshAccessToken(String refreshToken) {
    // TODO: implement refreshAccessToken
    throw UnimplementedError();
  }
}