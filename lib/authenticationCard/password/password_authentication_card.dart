import 'dart:convert';
import 'package:flutter_moshimoshi/authenticationCard/authentication_card_interface.dart';
import 'package:flutter_moshimoshi/entities/endpoint.dart';
import 'package:flutter_moshimoshi/entities/token.dart';
import 'package:flutter_moshimoshi/entities/tokens.dart';
import 'package:flutter/material.dart';

class PasswordAuthenticationCard implements AuthenticatorCardInterface {
  late final Endpoint loginEndpoint;
  late final Endpoint refreshEndpoint;
  late final int refreshExpirationTime;
  late final BuildContext context;
  late final StatefulWidget loginFailedDestination;

  PasswordAuthenticationCard({
    required this.loginEndpoint,
    required this.refreshEndpoint,
    required this.context
  });

  @override
  Future<Tokens?> getCurrentToken(Map<String, dynamic> parameters) async {
    loginEndpoint.formParams.addAll(parameters);
    final response = await loginEndpoint.call();
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      final accessToken = Token(data["access_token"], data["expires_in"]);
      final refreshToken = Token(data["refresh_token"], 800000);
      return Tokens(accessToken: accessToken, refreshToken: refreshToken);
    } else {
      showLogin();
      return null;
    }
  }

  @override
  Future<Tokens?> refreshAccessToken(String refreshToken) async {
    final refreshTokenEntry = <String, String>{"refresh_token": refreshToken};
    loginEndpoint.formParams.addEntries(refreshTokenEntry.entries);
    final response = await loginEndpoint.call();
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      final accessToken = Token(data["access_token"], data["expires_in"]);
      final refreshToken = Token(data["refresh_token"], 800000);
      return Tokens(accessToken: accessToken, refreshToken: refreshToken);
    } else {
      showLogin();
      return null;
    }
  }

  @override
  Future<void> logout() async {
    showLogin();
  }

  void showLogin() {
    //Navigator.of(context)
    //        .pushReplacement(MaterialPageRoute(builder: (context) => const loginFailedDestination()));
  }
}