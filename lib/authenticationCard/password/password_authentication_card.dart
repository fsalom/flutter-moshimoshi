import 'dart:convert';

import 'package:flutter_moshimoshi/authenticationCard/authentication_card_interface.dart';
import 'package:flutter_moshimoshi/authenticationCard/password/dto/tokensDTO.dart';
import 'package:flutter_moshimoshi/entities/endpoint.dart';
import 'package:flutter_moshimoshi/entities/tokens.dart';
import 'package:http/http.dart' as http;

class PasswordAuthenticationCard implements AuthenticatorCardInterface {
  late final Endpoint loginEndpoint;
  late final Endpoint refreshEndpoint;

  PasswordAuthenticationCard({
    required this.loginEndpoint,
    required this.refreshEndpoint
  });

  @override
  Future<Tokens> getCurrentToken(List<Parameter> parameters) async {
    try {
      final url = Uri.parse(loginEndpoint.url); 
      http.post(url, headers: loginEndpoint.headers, body: loginEndpoint.body)
      var completeLoginEndpoint = loginEndpoint;
      completeLoginEndpoint.add(parameters);
      final request = completeLoginEndpoint.getRequest();
      final response = await http.get(completeLoginEndpoint.uri)
      final parsed = jsonDecode(response.stream.toString());
      final Map<String, dynamic> tokensData =
          json.decode(response.stream.toString());
      TokensDTO
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Tokens?> refreshAccessToken(String refreshToken) async {
    try {
      var completeRefreshEndpoint = refreshEndpoint;
      var refreshParameter = Parameter(key: "refresh_token", value: refreshToken);
      completeRefreshEndpoint.add([refreshParameter]);
      final request = completeRefreshEndpoint.getRequest();
      final response = await http.Client().send(request);
      
      final Map<String, dynamic> tokensData = response.body;
          json.decode(utf8.decode(response.bodyBytes));
      return TokensDTO.fromJson(tokensData).toDomain();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    showLogin();
  }

  void showLogin() {
    // Puedes implementar la navegación a la pantalla de inicio de sesión en Flutter
    // utilizando Navigator, MaterialPageRoute, etc.
  }
}