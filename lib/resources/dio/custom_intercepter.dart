import 'package:dio/dio.dart';

class CustomIntercepter extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(options.uri);

    // TODO: implement onRequest
    return super.onRequest(options, handler);
  }
}
