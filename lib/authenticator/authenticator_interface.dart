import "package:dio/dio.dart";
import "package:flutter_moshimoshi/storage/storage_interface.dart";

abstract class AuthenticatorInterface {
    late StorageInterface tokenStore;
    Future<RequestOptions> authorize(RequestOptions request);
    Future<void> getNewToken(String parameters);
    Future<String> getCurrentToken();
    Future<bool> isLogged();
    Future<void> logout();
}