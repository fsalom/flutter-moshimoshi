import 'dart:convert';
import 'package:flutter_moshimoshi/authenticationCard/authentication_card_interface.dart';
import 'package:flutter_moshimoshi/entities/endpoint.dart';
import 'package:flutter_moshimoshi/entities/token.dart';
import 'package:flutter_moshimoshi/entities/tokens.dart';
import 'package:flutter/material.dart';

import '../../entities/detail_exception.dart';

class PasswordAuthenticationCard implements AuthenticatorCardInterface {
  late final Endpoint loginEndpoint;
  late final Endpoint refreshEndpoint;
  BuildContext? context;
  Widget? loginPage;
  GlobalKey<NavigatorState>? navigatorKey;

  // Constructor con BuildContext y loginPage
  PasswordAuthenticationCard({
    required this.loginEndpoint,
    required this.refreshEndpoint,
    required this.context,
    required this.loginPage,
  });

  // Named constructor con navigatorKey y route
  PasswordAuthenticationCard.withNavigatorKey({
    required this.loginEndpoint,
    required this.refreshEndpoint,
    required this.navigatorKey,
    required this.loginPage,
  });

  @override
  Future<Tokens> getCurrentToken({required Map<String, dynamic> parameters, Endpoint? endpoint}) async {
    var authenticationEndpoint = endpoint ?? loginEndpoint;
    authenticationEndpoint.data.addAll(parameters);
    final response = await authenticationEndpoint.call();

    if (response.statusCode == null) {
      throw DetailException(-1, "No status code received from server");
    }

    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      final data = _parseResponseData(response);

      final accessToken = Token(data["access_token"], data["expires_in"], 0);
      final refreshToken = Token(data["refresh_token"], 800000, 0);
      return Tokens(accessToken: accessToken, refreshToken: refreshToken);
    } else {
      throw _handleError(response);
    }
  }

  @override
  Future<Tokens?> refreshAccessToken(String refreshToken) async {
    final refreshTokenEntry = <String, String>{"refresh_token": refreshToken};
    refreshEndpoint.data.addEntries(refreshTokenEntry.entries);
    final response = await refreshEndpoint.call();
    if (response.statusCode == 200) {
      final data = _parseResponseData(response);

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
    if (context != null && loginPage != null) {
      Navigator.of(context!).pushReplacement(
        MaterialPageRoute(builder: (context) => loginPage!),
      );
    } else if (navigatorKey != null && navigatorKey!.currentState != null && loginPage != null) {
      navigatorKey!.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => loginPage!),
        (route) => false,
      );
    }
  }

  DetailException _handleError(dynamic response) {
    final int statusCode = response.statusCode ?? -1;
    String? message;

    try {
      final data = response.data;
      message = _extractErrorMessage(data) ?? data?.toString() ?? "Error desconocido";
    } catch (_) {
      message = response.data?.toString() ?? response.toString();
    }

    return DetailException(statusCode, message);
  }

  String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data["message"]?.toString();
    }

    if (data is List<dynamic> && data.isNotEmpty && data.first is Map<String, dynamic>) {
      return (data.first as Map<String, dynamic>)["message"]?.toString();
    }

    if (data is String) {
      try {
        final parsedData = jsonDecode(data);
        if (parsedData is Map<String, dynamic>) {
          return parsedData["message"]?.toString();
        }
        if (parsedData is List<dynamic> && parsedData.isNotEmpty && parsedData.first is Map<String, dynamic>) {
          return (parsedData.first as Map<String, dynamic>)["message"]?.toString();
        }
      } catch (_) {
        return null;
      }
    }

    return null;
  }

  Map<String, dynamic> _parseResponseData(dynamic response) {
    final data = response.data;

    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is List<dynamic> && data.isNotEmpty && data.first is Map<String, dynamic>) {
      return data.first as Map<String, dynamic>;
    }

    if (data is String) {
      try {
        final parsedData = jsonDecode(data);
        if (parsedData is Map<String, dynamic>) {
          return parsedData;
        }
        if (parsedData is List<dynamic> && parsedData.isNotEmpty && parsedData.first is Map<String, dynamic>) {
          return parsedData.first as Map<String, dynamic>;
        }
      } catch (_) {
        throw DetailException(response.statusCode ?? -1, "Invalid JSON string in response");
      }
    }

    throw DetailException(response.statusCode ?? -1, "Response data is not a valid Map or List with Map elements");
  }
}
