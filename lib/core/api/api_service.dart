import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? params,
  }) async {
    bool result = await InternetConnection().hasInternetAccess;
    if (result) {
      var response = await _dio.get(endpoint, queryParameters: params);
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else {
        return {"data": response.data};
      }
    } else {
      throw 'Check your Internet Connection';
    }
  }
}
