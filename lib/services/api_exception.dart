class ApiException implements Exception {
  final String message;
  final int? code;

  ApiException({required this.message, this.code});

  @override
  String toString() {
    return 'ApiException: $message (code: $code)';
  }
}
