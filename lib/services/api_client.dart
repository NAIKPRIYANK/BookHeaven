

import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({String baseUrl = 'https://api.example.com', int connectTimeout = 5000, int receiveTimeout = 3000})
      : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: Duration(milliseconds: connectTimeout),
    receiveTimeout: Duration(milliseconds: receiveTimeout),
  )) {
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true)); // Logging for debugging
  }

  Dio get dio => _dio;
}
