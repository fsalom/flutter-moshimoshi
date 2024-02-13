import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter_moshimoshi/authenticator/authenticator_interface.dart';
import 'package:flutter_moshimoshi/storage/storage_interface.dart';
import 'package:http/http.dart' as http;

class Authenticator implements AuthenticatorInterface {
  @override
  late StorageInterface tokenStore;

  init(StorageInterface tokenStore) {
    this.tokenStore = tokenStore;
  }
  
  @override
  Future<RequestOptions> authorize(RequestOptions request) async {
      var accessToken = Isolate.run<String>(() {    
        return getCurrentToken();
      });
      request.headers["Authorization"] = "Bearer $accessToken";
      return request;
  }
  
  @override
  Future<String> getCurrentToken() {
    // TODO: implement getCurrentToken
    throw UnimplementedError();
  }
  
  @override
  Future<void> getNewToken(String parameters) {
    // TODO: implement getNewToken
    throw UnimplementedError();
  }
  
  @override
  Future<bool> isLogged() {
    // TODO: implement isLogged
    throw UnimplementedError();
  }
  
  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

}