import 'package:flutter_moshimoshi/entities/Token.dart';

abstract class StorageInterface {
  Token getAccessToken();
  void setAccessToken({dynamic token = Token});
  Token getRefreshToken();
  void setRefreshToken();
  void clear();
}