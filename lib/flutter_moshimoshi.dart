library flutter_moshimoshi;
import 'dart:core';
import 'dart:developer';
import 'dart:js_util';
import 'package:dio/dio.dart';
import 'package:flutter_moshimoshi/authenticationCard/authentication_card_interface.dart';
import 'package:flutter_moshimoshi/authenticator/authenticator_interface.dart';
import 'package:flutter_moshimoshi/storage/storage_interface.dart';

class MoshiMoshi {
  var timeout = const Duration(seconds: 30);
  late AuthenticatorInterface authenticator;
  late StorageInterface storage;
  late Dio dio;

  init(AuthenticatorInterface authenticator, StorageInterface storage, Interceptor interceptor) {
    this.authenticator = authenticator;
    this.storage = storage;
    dio = Dio(BaseOptions( connectTimeout: timeout));
    dio.interceptors.add(interceptor);
  }

  load() {
    
  }
}
