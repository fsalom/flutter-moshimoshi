import 'package:dio/dio.dart';

enum InterceptorType {
  authenticated,
  nonAuthenticated,
}

class MoshiInterceptor {
  InterceptorType type;
  Interceptor interceptor;

  MoshiInterceptor({required this.type, required this.interceptor}) {
    type = type;
    interceptor = interceptor;
  }
}
