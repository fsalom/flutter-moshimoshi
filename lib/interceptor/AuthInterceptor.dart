
import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_moshimoshi/authenticator/authenticator_interface.dart';

class AuthInterceptor extends Interceptor {
  late final AuthenticatorInterface authenticator;
  final _requestQueue = Queue<Completer<void>>();

  AuthInterceptor({required this.authenticator });
  

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(">>> DIO REQUEST PATH: ${options.path}");
    log(">>> DIO REQUEST HEADERS: ${options.headers}");

    final completer = Completer<void>();
    _requestQueue.add(completer);

    // Esperar a que se complete la solicitud anterior (si la hay) antes de continuar
    if (_requestQueue.length > 1) {
      completer.future.then((_) {
        handler.next(options);
      });
    } else {
      _processRequest(options, handler, completer);
    }
  }

  void _processRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
    Completer<void> completer,
  ) async {
    try {
      // Obtener el token de forma asíncrona
      final accessToken = await _getToken();
      if (accessToken != null) {
        options.headers["Authorization"] = "Bearer $accessToken";
      }
      handler.next(options);
    } finally {
      completer.complete(); // Marcar la solicitud como completada
      _requestQueue.removeFirst(); // Eliminar la solicitud de la cola
    }
  }

  Future<String?> _getToken() async {
    // Lógica para obtener el token aquí, por ejemplo, puedes usar await para
    // operaciones asíncronas.
    return await authenticator.getCurrentToken();
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Manejar específicamente el código de estado 401
    if (err.response?.statusCode == 401) {
      // Realizar acciones específicas para el código de estado 401, como redirección a la página de inicio de sesión
      // También puedes elegir no arrojar una excepción para evitar que se propague el error.
      log("Error 401: Redirección a la página de inicio de sesión");
    } else {
      // Manejar otros errores según sea necesario
      super.onError(err, handler);
    }
  }
}