class ServerException implements Exception {
  final int statusCode;
  String message;
  String code;

  ServerException(
      {required this.statusCode, this.message = '', this.code = ''});

  factory ServerException.fromJson(Map<String, dynamic> data) {
    if (data.containsKey('error')) {
      var error = data['error'];
      return ServerException(
          statusCode: error['statusCode'],
          code: error['code'],
          message: error['message']);
    }
    return ServerException(
        statusCode: 500,
        code: 'unexpected.server',
        message: 'Unexpected error');
  }
}
