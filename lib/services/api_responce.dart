class ApiResponse<T> {
  T? data;
  String? message;
  bool success;

  ApiResponse({this.data, this.message, this.success = true});

  factory ApiResponse.success(T data) {
    return ApiResponse(data: data, success: true);
  }

  factory ApiResponse.failure(String message) {
    return ApiResponse(message: message, success: false);
  }
}
