import "package:dio/dio.dart";
import "package:flutter_moshimoshi/entities/endpoint.dart";
import "package:flutter_moshimoshi/storage/storage_interface.dart";

abstract interface class AuthenticatorInterface {
  late StorageInterface tokenStore;
  Future<RequestOptions> authorize(RequestOptions request);
  Future<void> getNewToken({
    required Map<String, dynamic> parameters,
    Endpoint? endpoint,
  });
  Future<String?> getCurrentToken();
  Future<bool> isLogged();
  Future<void> logout();
}
