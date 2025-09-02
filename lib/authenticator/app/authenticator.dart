import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter_moshimoshi/authenticationCard/authentication_card_interface.dart';
import 'package:flutter_moshimoshi/authenticator/authenticator_interface.dart';
import 'package:flutter_moshimoshi/entities/endpoint.dart';
import 'package:flutter_moshimoshi/entities/detail_exception.dart';
import 'package:flutter_moshimoshi/entities/tokens.dart';
import 'package:flutter_moshimoshi/storage/storage_interface.dart';

class Authenticator implements AuthenticatorInterface {
  @override
  late StorageInterface tokenStore;
  late AuthenticatorCardInterface card;

  Authenticator(this.tokenStore, this.card);

  @override
  Future<RequestOptions> authorize(RequestOptions request) async {
    var accessToken = Isolate.run<String?>(() {
      return getCurrentToken();
    });
    request.headers["Authorization"] = "Bearer $accessToken";
    return request;
  }

  @override
  Future<String?> getCurrentToken() async {
    try {
      var tokens = await checkAccess();
      return tokens.accessToken.value;
    } catch (error) {
      logout();
      return null;
    }
  }

  @override
  Future<void> getNewToken({
    required Map<String, dynamic> parameters,
    Endpoint? endpoint,
  }) async {
    try {
      final tokens = await card.getCurrentToken(parameters: parameters, endpoint: endpoint);
      tokenStore.setAccessToken(tokens.accessToken);
      tokenStore.setRefreshToken(tokens.refreshToken);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isLogged() async {
    try {
      await checkAccess();
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    tokenStore.clear();
    card.logout();
  }

  Future<Tokens> checkAccess() async {
    try {
      var accessToken = await tokenStore.getAccessToken();
      var refreshToken = await tokenStore.getRefreshToken();
      if (accessToken.isValid) {
        return Tokens(accessToken: accessToken, refreshToken: refreshToken);
      } else {
        if (refreshToken.isValid) {
          var tokens = await card.refreshAccessToken(refreshToken.value);
          if (tokens != null) {
            tokenStore.setAccessToken(tokens.accessToken);
            tokenStore.setRefreshToken(tokens.refreshToken);
            return tokens;
          }
        }
        tokenStore.clear();
        throw DetailException;
      }
    } catch (error) {
      tokenStore.clear();
      throw DetailException;
    }
  }
}
