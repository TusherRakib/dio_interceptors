import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import 'dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] => BASEURL: ${options.baseUrl} => ENDPOINT: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      'RESPONSE[${response.statusCode}] => BASEURL: ${response.requestOptions.baseUrl} => ENDPOINT: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    log(
        'ERROR[${err.type.name}] => ERROR: ${err.error}=> BASEURL: ${err.requestOptions.baseUrl} => ENDPOINT: ${err.requestOptions.path}');
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        return e;
      }
    }
    return err;
  }

  bool _shouldRetry(DioError err) {


    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }
}