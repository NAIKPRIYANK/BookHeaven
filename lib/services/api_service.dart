import 'dart:convert';

import 'package:dio/dio.dart';

import 'api_client.dart';
import 'api_responce.dart';

typedef ApiResponseCallback<T> = void Function(ApiResponse<T> response);

class GenericApiService {
  final ApiClient apiClient;

  GenericApiService({required this.apiClient});

  void getRequest<T>(String endpoint,
      {Map<String, dynamic>? queryParams,
      required ApiResponseCallback<T> callback}) {
    apiClient.dio.get(endpoint, queryParameters: queryParams).then((response) {
      callback(_handleResponse<T>(response));
    }).catchError((error) {
      callback(_handleError<T>(error));
    });
  }

  void postRequest<T>(String endpoint, dynamic data,
      {required ApiResponseCallback<T> callback}) {
    apiClient.dio.post(endpoint, data: data).then((response) {
      callback(_handleResponse<T>(response));
    }).catchError((error) {
      callback(_handleError<T>(error));
    });
  }

  void putRequest<T>(String endpoint, dynamic data,
      {required ApiResponseCallback<T> callback}) {
    apiClient.dio.put(endpoint, data: data).then((response) {
      callback(_handleResponse<T>(response));
    }).catchError((error) {
      callback(_handleError<T>(error));
    });
  }

  void deleteRequest<T>(String endpoint,
      {Map<String, dynamic>? queryParams,
      required ApiResponseCallback<T> callback}) {
    apiClient.dio
        .delete(endpoint, queryParameters: queryParams)
        .then((response) {
      callback(_handleResponse<T>(response));
    }).catchError((error) {
      callback(_handleError<T>(error));
    });
  }

  ApiResponse<T> _handleResponse<T>(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data is T) {
        return ApiResponse.success(response.data);
      } else {
        // Try to parse the response as JSON if not directly of type T
        final data = json.decode(response.data.toString()) as T;
        return ApiResponse.success(data);
      }
    } else {
      return ApiResponse.failure('Error: ${response.statusMessage}');
    }
  }

  ApiResponse<T> _handleError<T>(dynamic error) {
    if (error is DioException) {
      return ApiResponse.failure("${error.error}");
    } else {
      return ApiResponse.failure('Unexpected error occurred');
    }
  }
}

//https://chatgpt.com/share/e04342e7-473f-4f56-a8d8-5db22e229b2b