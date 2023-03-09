import 'dart:developer';
import 'package:dio/dio.dart';
import 'collections_model.dart';
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