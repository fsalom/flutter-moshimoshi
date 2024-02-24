import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

enum Method { get, post, put, patch }

class Endpoint {
  late String url;
  late Method method;
  Map<String, String> headers = {};
  Map<String, String> queryParams = {};
  Map<String, dynamic> formParams = {};

  Endpoint({this.url = "", required this.headers, this.method = Method.get});

  Future<Response> call() {
    final url = Uri.parse(this.url); 
    final body = jsonEncode(formParams);
    switch (method) {
      case Method.get:
        return http.get(url, headers: headers);
      case Method.post:
        return http.post(url, headers: headers, body: body);    
      case Method.put:
        return http.put(url, headers: headers, body: body);    
      case Method.patch:
        return http.patch(url, headers: headers, body: body);    
    }
  }
}