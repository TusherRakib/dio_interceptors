import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_interceptors/dio_connectivity_request_retrier.dart';
import 'package:dio_interceptors/retry_interceptor.dart';
import 'package:get/get.dart';

Network network = Network();

BaseOptions options = BaseOptions(
  baseUrl: 'http://146.190.105.67/api/v1/',
  connectTimeout: 60 * 1000,
  receiveTimeout: 60 * 1000,
  headers: {HttpHeaders.contentTypeHeader: 'application/json'},
);

class Network {
  // Network() {
  //   if (authenticationController.state is Authenticated) {
  //     String token =
  //     (authenticationController.state as Authenticated).user.data?.token??'';
  //     options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
  //     //options.headers.addAll({'authorization': token, HttpHeaders.contentTypeHeader: ContentType.json});
  //   } else {
  //     //log('Api(): UnAuthenticated- No token found');
  //   }
  // }

  Dio getDio({bool isFormData = false}) {
    options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    options.headers[HttpHeaders.acceptHeader] = 'application/json';

    if (isFormData) {
      //debugPrint('isFormData: ' + isFormData.toString());
      options.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';
    }

    Dio dio = Dio(options);

    return dio..interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
            dio: dio, connectivity: Connectivity())
    ));

    return Dio(options)
      ..interceptors.add(RetryOnConnectionChangeInterceptor(requestRetrier: DioConnectivityRequestRetrier(dio: Dio(options), connectivity: Connectivity())));
  }
}

// class Logging extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     print('REQUEST[${options.method}] => PATH: ${options.path}');
//     return super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     print(
//       'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
//     );
//     return super.onResponse(response, handler);
//   }
//
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     print(
//       'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
//     );
//     return super.onError(err, handler);
//   }
// }
