String createExtension(){
  return """
class CommonException implements Exception {
  final int errorCode;
  final String message;

  CommonException({
    required this.errorCode,
    required this.message
  });

  @override
  String toString() {
    return "CommonException: \$errorCode - \$message";
  }
}

""";
}
