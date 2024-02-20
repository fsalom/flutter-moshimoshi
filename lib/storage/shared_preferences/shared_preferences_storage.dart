import 'package:flutter_moshimoshi/entities/token.dart';
import 'package:flutter_moshimoshi/storage/storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements StorageInterface {
  static const String accessTokenKey = "ACCESSTOKEN_KEY";
  static const String refreshTokenKey = "REFRESHTOKEN_KEY";
  static const String expiresInKey = "EXPIRESIN_KEY";
  static const String accessExpirationTimeKey = "ACCESSEXPIRATIONTIME_KEY";
  static const String refreshExpirationTimeKey = "REFRESHEXPIRATIONTIME_KEY";

  late SharedPreferences preferences;

  Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> clear() async {
    preferences.remove("access_token");
    preferences.remove("refresh_token");
  }

  @override
  Future<Token> getAccessToken() async {
    var accessToken= preferences.getString(accessTokenKey);
    var expiresIn = preferences.getInt(expiresInKey);
    var expirationTime = preferences.getInt(accessExpirationTimeKey);

    if(accessToken != null && expirationTime != null && expiresIn != null) {
      return Token(accessToken, expiresIn, expirationTime);      
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<Token> getRefreshToken() async {
    var refreshToken = preferences.getString(refreshTokenKey);
    var expirationTime = preferences.getInt(refreshExpirationTimeKey);
    if(refreshToken != null && expirationTime != null) {
      return Token(refreshToken, 0, expirationTime);      
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> setAccessToken(Token token) async {
    preferences.setString(accessTokenKey, token.value);
    preferences.setInt(accessExpirationTimeKey, token.expirationTime);
    preferences.setInt(expiresInKey, token.expiresIn);
  }

  @override
  Future<void> setRefreshToken(Token token) async {
    preferences.setString(refreshTokenKey, token.value);
    preferences.setInt(refreshExpirationTimeKey, token.expirationTime);
  }

}