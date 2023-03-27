import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_interceptors/controller.dart';
import 'package:dio_interceptors/retry_interceptor.dart';
import 'package:get/get.dart';
import 'collections_model.dart';
import 'dio_connectivity_request_retrier.dart';
import 'network.dart';

Future<CollectionListModel?> getCollectionListApi(int operationType, int placement) async {
  Map<String, dynamic> map = {
    "operation_type": operationType,
    "placement": placement,
  };

  var result;

  try {
    Dio dio = network.getDio();
    result = await dio.get('collections',queryParameters: map);
    log(result.toString());
  } on DioError catch (e) {
    log(e.toString());
  }
  if (result != null) {
    CollectionListModel homeCollectionListModel = CollectionListModel.fromJson(result.data);
    return homeCollectionListModel;
  }
  return null;
}