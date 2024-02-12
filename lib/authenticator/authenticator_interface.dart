import "package:flutter_moshimoshi/storage/storage_interface.dart";

abstract class AuthenticatorInterface {
    late StorageInterface tokenStore;
    Uri authorize(Uri request);
    void getNewToken(String parameters);
    String getCurrentToken();
    bool isLogged();
    void logout();
}