import 'package:flutter_moshimoshi/entities/token.dart';

abstract class StorageInterface {
  Future<Token> getAccessToken();
  Future<void> setAccessToken(Token token);
  Future<Token> getRefreshToken();
  Future<void> setRefreshToken(Token token);
  Future<void> clear();
}