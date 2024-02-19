import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

enum Method { GET, POST, PUT, PATCH }

class Endpoint {
  late String url;
  late Method method;
  late Map<String, String> queryParams;
  late Map<String, String> headers;
  late Map<String, dynamic> formParams;

  Endpoint({this.url = "", this.method = Method.GET});

  Future<Response> call() {
    final url = Uri.parse(this.url); 
    final body = jsonEncode(formParams);
    switch (method) {
      case Method.GET:
        return http.get(url, headers: headers);
      case Method.POST:
        return http.post(url, headers: headers, body: body);    
      case Method.PUT:
        return http.post(url, headers: headers, body: body);    
      case Method.PATCH:
        return http.post(url, headers: headers, body: body);    
    }
  }
}