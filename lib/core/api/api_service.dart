import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? params,
  }) async {
    var response = await _dio.get(endpoint, queryParameters: params);
    if (response.data is Map<String, dynamic>) {
      return response.data;
    } else {
      return {"data": response.data};
    }
  }
}
