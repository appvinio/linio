import 'package:dio/dio.dart';
import 'package:linio/linio.dart';

class PrettyDioLoggerInterceptor extends Interceptor with LinioPlugin  {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    linio.log(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    linio.log(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    linio.log(error);
    super.onError(error, handler);
  }
}