class FileNotFoundException implements Exception {
  final String message;

  const FileNotFoundException({
    required this.message
  });

  @override
  String toString() {
    return "FileNotFoundException: \$message";
  }
}
