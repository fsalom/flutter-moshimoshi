import 'package:example/constants/constants.dart';
import 'package:example/main.dart';
import 'package:example/presentation/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_moshimoshi/authenticationCard/password/password_authentication_card.dart';
import 'package:flutter_moshimoshi/authenticator/app/authenticator.dart';
import 'package:flutter_moshimoshi/entities/endpoint.dart';
import 'package:flutter_moshimoshi/flutter_moshimoshi.dart';
import 'package:flutter_moshimoshi/interceptor/AuthInterceptor.dart';
import 'package:flutter_moshimoshi/storage/shared_preferences/shared_preferences_storage.dart';
import 'package:flutter_moshimoshi/storage/storage_interface.dart';

class Endpoints {
  static var loginEndpoint = Endpoint(
    url: '${Constants.baseUrl}/auth/token',
    headers: {"Content-Type": "application/json"}, 
    method: Method.post,
  );

  static var refreshEndpoint = Endpoint(
    url: '${Constants.baseUrl}/auth/token',
    headers: {"Content-Type": "application/json"},
    method: Method.post,
  );
}

class Di {
  BuildContext? _context;

  StorageInterface tokenStore = SharedPreferencesStorage();
  late PasswordAuthenticationCard card;
  late AuthInterceptor interceptor;

  Authenticator? _authenticator;
  MoshiMoshi? _moshi;
    
  factory Di() {
    return _singleton;
  }

  MoshiMoshi? get moshi => _moshi;
  Authenticator? get authenticator => _authenticator;

  Di._internal();
  
  static final Di _singleton = Di._internal();

  void setContext(BuildContext context) {
    _context = context;

    card = PasswordAuthenticationCard(
      loginEndpoint: Endpoints.loginEndpoint,
      refreshEndpoint: Endpoints.refreshEndpoint,
      context: _context!,
      loginPage: LoginPage(),
    );    
    _authenticator = Authenticator(tokenStore, card);
    interceptor = AuthInterceptor(authenticator: _authenticator!);
    _moshi = MoshiMoshi(
      authenticator: _authenticator!,
      storage: tokenStore,
      interceptors: [interceptor],
    );    
  }
}