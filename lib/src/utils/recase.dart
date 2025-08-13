extension StringCasingExtension on String {
  String toLowerCamelCase() {
    List<String> parts = split(RegExp(r'[-_\s]'));

    if (parts.isEmpty) {
      return '';
    }

    String result = parts[0].toLowerCase();

    for (int i = 1; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        result += parts[i][0].toUpperCase() + parts[i].substring(1).toLowerCase();
      }
    }

    return result;
  }

  String toLowerSnakeCase() {
    return replaceAllMapped(RegExp(r'([A-Z])'), (Match m) => '_${m.group(1)}')
        .toLowerCase()
        .replaceAll(RegExp(r'[\s-]+'), '_');
  }
}
