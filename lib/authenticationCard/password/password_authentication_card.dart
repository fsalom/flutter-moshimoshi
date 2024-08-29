import 'dart:convert';
import 'package:flutter_moshimoshi/authenticationCard/authentication_card_interface.dart';
import 'package:flutter_moshimoshi/entities/endpoint.dart';
import 'package:flutter_moshimoshi/entities/token.dart';
import 'package:flutter_moshimoshi/entities/tokens.dart';
import 'package:flutter/material.dart';

class PasswordAuthenticationCard implements AuthenticatorCardInterface {
  late final Endpoint loginEndpoint;
  late final Endpoint refreshEndpoint;
  final BuildContext? context;
  final Widget loginPage;

  PasswordAuthenticationCard({
    required this.loginEndpoint,
    required this.refreshEndpoint,
    required this.context,
    required this.loginPage
  });

  @override
  Future<Tokens?> getCurrentToken(Map<String, dynamic> parameters, {Endpoint? endpoint}) async {
    var authenticationEndpoint = loginEndpoint;
    if (endpoint != null) {
      authenticationEndpoint = endpoint;
    }
    authenticationEndpoint.formParams.addAll(parameters);
    final response = await authenticationEndpoint.call();
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      final accessToken = Token(data["access_token"], data["expires_in"], 0);
      final refreshToken = Token(data["refresh_token"], 800000, 0);
      final tokens = Tokens(accessToken: accessToken, refreshToken: refreshToken);
      return tokens;
    } else {
      return null;
    }
  }

  @override
  Future<Tokens?> refreshAccessToken(String refreshToken) async {
    final refreshTokenEntry = <String, String>{"refresh_token": refreshToken};
    refreshEndpoint.formParams.addEntries(refreshTokenEntry.entries);
    final response = await refreshEndpoint.call();
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      var accessToken = Token(data["access_token"], data["expires_in"], 0);
      var refreshToken = Token(data["refresh_token"], 800000, 0);
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
    if(context != null ){
    Navigator.of(context!)
          .pushReplacement(MaterialPageRoute(builder: (context) => loginPage));
          }
  }
}