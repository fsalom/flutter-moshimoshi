import 'package:dio/dio.dart';

enum Method { get, post, put, patch, delete }

class Endpoint {
  final String url;
  final Method method;
  final Map<String, String> headers;
  final Map<String, String> queryParameters;
  final Map<String, dynamic> data;
  final Interceptor? loggerInterceptor;

  Endpoint({
    required this.url,
    this.method = Method.get,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Map<String, dynamic>? data,
    this.loggerInterceptor,
  })  : headers = headers ?? <String, String>{},
        queryParameters = queryParameters ?? <String, String>{},
        data = data ?? <String, dynamic>{},
        assert(url.isNotEmpty, 'La URL no puede estar vacía');

  Future<Response> call() async {
    final dio = Dio();

    if (loggerInterceptor != null) dio.interceptors.add(loggerInterceptor!);

    final options = Options(headers: headers.isNotEmpty ? headers : null);
    final queryParams = queryParameters.isNotEmpty ? queryParameters : null;
    final bodyData = data.isNotEmpty ? data : null;

    switch (method) {
      case Method.get:
        return await dio.get(
          url,
          queryParameters: queryParams,
          options: options,
        );
      case Method.post:
        return await dio.post(
          url,
          queryParameters: queryParams,
          data: bodyData,
          options: options,
        );
      case Method.put:
        return await dio.put(
          url,
          queryParameters: queryParams,
          data: bodyData,
          options: options,
        );
      case Method.patch:
        return await dio.patch(
          url,
          queryParameters: queryParams,
          data: bodyData,
          options: options,
        );
      case Method.delete:
        return await dio.delete(
          url,
          queryParameters: queryParams,
          data: bodyData,
          options: options,
        );
    }
  }
}
