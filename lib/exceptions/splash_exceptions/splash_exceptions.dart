class NoDataFoundException implements Exception {
  final String message;

  NoDataFoundException({required this.message});

  @override
  String toString() {
    return 'No data found: $message';
  }
}

class ErrorFetchingData implements Exception {
  final String message;

  ErrorFetchingData({required this.message});

  @override
  String toString() {
    return 'Error fetching data: $message';
  }
}
