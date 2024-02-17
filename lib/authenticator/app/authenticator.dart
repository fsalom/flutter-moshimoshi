import 'dart:ffi';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter_moshimoshi/authenticationCard/authentication_card_interface.dart';
import 'package:flutter_moshimoshi/authenticator/authenticator_interface.dart';
import 'package:flutter_moshimoshi/entities/error.dart';
import 'package:flutter_moshimoshi/entities/tokens.dart';
import 'package:flutter_moshimoshi/storage/storage_interface.dart';
import 'package:http/http.dart' as http;

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
    var tokens = await checkAccess().catchError((error) {
      logout();
      });
    return tokens.acccesToken.value;
  }
  
  @override
  Future<void> getNewToken(String parameters) {
    // TODO: implement getNewToken
    throw UnimplementedError();
  }
  
  @override
  Future<bool> isLogged() async {
    var tokens = await checkAccess();
    return true;
  }
  
  @override
  Future<void> logout() async {
    tokenStore.clear();
    card.logout();
  }

  Future<Tokens> checkAccess() async {
    var accessToken = await tokenStore.getAccessToken()
    .catchError((error) {
         logout();
      });
    var refreshToken = await tokenStore.getRefreshToken()
    .catchError((error) {
         logout();
      });
    if (accessToken.isValid) {
      return Tokens(accessToken, refreshToken);
    } else {
      if (refreshToken.isValid) {
        var tokens = await card.refreshAccessToken(refreshToken.value);
        tokenStore.setAccessToken(tokens.acccesToken);
        tokenStore.setRefreshToken(tokens.refreshToken);    
        return tokens;
      } else {
        await logout();
        throw AuthorizationFailed();
      }
    } 
  }
}