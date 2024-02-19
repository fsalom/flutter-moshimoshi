import 'package:http/http.dart' as http;

enum Method { GET, POST, PUT, PATCH }

class Parameter {
  String key;
  String value;

  Parameter({required this.key, required this.value});
}

class Endpoint {
  late String url;
  late Method method;
  List<Parameter> parameters = [];
  List<Parameter> queryParams = [];
  List<Parameter> formParams = [];

  Endpoint({this.url = "", this.method = Method.GET});

  bool checkIfExists(List<Parameter> list, String key) {
    for (var param in list) {
      if (param.key == key) {
        return true;
      }
    }
    return false;
  }

  void add(List<Parameter> formParams) {
    formParams.forEach((param) {
      if (!checkIfExists(this.formParams, param.key)) {
        this.formParams = [...this.formParams, param];
      } else {
        this.formParams
            .where((it) => it.key == param.key)
            .forEach((it) => it.value = param.value);
      }
    });
  }

  http.Request getRequest() {
    var request = http.Request(method.toString(), Uri.parse(url));

    if (formParams.isNotEmpty) {
      request.headers['Content-Type'] = 'application/x-www-form-urlencoded';
      request.body = formParams.map((param) {
        return '${param.key}=${param.value}';
      }).join('&');
    }

    return request;
  }
}