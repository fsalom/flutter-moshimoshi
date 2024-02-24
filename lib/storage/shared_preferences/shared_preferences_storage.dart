import 'package:flutter_moshimoshi/entities/token.dart';
import 'package:flutter_moshimoshi/storage/storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements StorageInterface {
  static const String accessTokenKey = "ACCESSTOKEN_KEY";
  static const String refreshTokenKey = "REFRESHTOKEN_KEY";
  static const String expiresInKey = "EXPIRESIN_KEY";
  static const String accessExpirationTimeKey = "ACCESSEXPIRATIONTIME_KEY";
  static const String refreshExpirationTimeKey = "REFRESHEXPIRATIONTIME_KEY";

  Future<SharedPreferences> preferences = SharedPreferences.getInstance();

/*
  SharedPreferencesStorage() {
    initializer();
  }

  initializer() async {
    preferences = 
  }
*/
  @override
  Future<void> clear() async {
    var storage = await preferences;
    storage.remove("access_token");
    storage.remove("refresh_token");
  }

  @override
  Future<Token> getAccessToken() async {
    var storage = await preferences;
    var accessToken= storage.getString(accessTokenKey);
    var expiresIn = storage.getInt(expiresInKey);
    var expirationTime = storage.getInt(accessExpirationTimeKey);

    if(accessToken != null && expirationTime != null && expiresIn != null) {
      return Token(accessToken, expiresIn, expirationTime);      
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<Token> getRefreshToken() async {
    var storage = await preferences;
    var refreshToken = storage.getString(refreshTokenKey);
    var expirationTime = storage.getInt(refreshExpirationTimeKey);
    if(refreshToken != null && expirationTime != null) {
      return Token(refreshToken, 0, expirationTime);      
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> setAccessToken(Token token) async {
    var storage = await preferences;
    storage.setString(accessTokenKey, token.value);
    storage.setInt(accessExpirationTimeKey, token.expirationTime);
    storage.setInt(expiresInKey, token.expiresIn);
  }

  @override
  Future<void> setRefreshToken(Token token) async {
    var storage = await preferences;
    storage.setString(refreshTokenKey, token.value);
    storage.setInt(refreshExpirationTimeKey, token.expirationTime);
  }

}