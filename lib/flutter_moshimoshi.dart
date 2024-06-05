library flutter_moshimoshi;
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter_moshimoshi/authenticator/authenticator_interface.dart';
import 'package:flutter_moshimoshi/storage/storage_interface.dart';

class MoshiMoshi {
  final _timeout = const Duration(seconds: 30);
  final AuthenticatorInterface authenticator;
  final StorageInterface storage;
  final List<Interceptor> interceptors;
  late Dio call;
  late Dio callAuthenticated;

  MoshiMoshi({
    required this.authenticator,
    required this.storage,
    required this.interceptors,
  }) {
    call = Dio(BaseOptions(connectTimeout: _timeout));
    callAuthenticated = Dio(BaseOptions(connectTimeout: _timeout));

    for (var interceptor in interceptors) {
      callAuthenticated.interceptors.add(interceptor);
    }
  }
}