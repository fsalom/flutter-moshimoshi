import "package:dio/dio.dart";
import "package:flutter_moshimoshi/storage/storage_interface.dart";

abstract class AuthenticatorInterface {    
    late StorageInterface tokenStore;
    Future<RequestOptions> authorize(RequestOptions request);
    Future<void> getNewToken(Map<String, dynamic> parameters);
    Future<String?> getCurrentToken();
    Future<bool> isLogged();
    Future<void> logout();
}