import 'dart:convert';
import 'package:flutter_moshimoshi/entities/Token.dart';
import 'package:flutter_moshimoshi/storage/storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements StorageInterface {
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
    var accessTokenJson = preferences.getString("access_token");
    if (accessTokenJson != null) {
      var accessToken = json.decode(accessTokenJson);
      return Token.fromJson(accessToken);
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<Token> getRefreshToken() async {
    var refreshTokenJson = preferences.getString("refresh_token");
    if (refreshTokenJson != null) {
      var refreshToken = json.decode(refreshTokenJson);
      return Token.fromJson(refreshToken);
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> setAccessToken(Token token) async {
    preferences.setString("access_token", json.encode(token));
  }

  @override
  Future<void> setRefreshToken(Token token) async {
    preferences.setString("access_token", json.encode(token));
  }

}