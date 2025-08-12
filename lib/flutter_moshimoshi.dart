import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter_moshimoshi/authenticator/authenticator_interface.dart';
import 'package:flutter_moshimoshi/entities/moshi_interceptor.dart';
import 'package:flutter_moshimoshi/storage/storage_interface.dart';

class MoshiMoshi {
  final _timeout = const Duration(seconds: 30);
  final AuthenticatorInterface authenticator;
  final StorageInterface storage;
  final List<MoshiInterceptor> interceptors;
  final String? baseUrl;

  late Dio call;
  late Dio callAuthenticated;

  MoshiMoshi({
    required this.authenticator,
    required this.storage,
    required this.interceptors,
    this.baseUrl,
  }) {
    call = Dio(BaseOptions(
      baseUrl: baseUrl ?? "",
      connectTimeout: _timeout,
    ));

    callAuthenticated = Dio(BaseOptions(
      baseUrl: baseUrl ?? "",
      connectTimeout: _timeout,
    ));

    for (var moshiInterceptor in interceptors) {
      switch (moshiInterceptor.type) {
        case InterceptorType.nonAuthenticated:
          call.interceptors.add(moshiInterceptor.interceptor);
          break;
        case InterceptorType.authenticated:
          callAuthenticated.interceptors.add(moshiInterceptor.interceptor);
          break;
      }
    }
  }
}
