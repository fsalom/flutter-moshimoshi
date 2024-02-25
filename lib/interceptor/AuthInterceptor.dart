
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_moshimoshi/authenticator/authenticator_interface.dart';

class AuthInterceptor extends Interceptor {
  late final AuthenticatorInterface authenticator;

  AuthInterceptor({required this.authenticator });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
    log(">>> DIO REQUEST PATH: ${options.path}");
    log(">>> DIO REQUEST HEADERS: ${options.headers}");
    authenticator.authorize(options);
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}