extension NestedMapAccess on Map<String, dynamic> {
  String? getNested(String path) {
    List<String> keys = path.split('.');
    dynamic current = this;

    for (String key in keys) {
      if (current is Map<String, dynamic> && current.containsKey(key)) {
        current = current[key];
      } else {
        return null;
      }
    }

    return current is String ? current : null;
  }

  void setNested(String path, String value) {
    List<String> keys = path.split('.');
    Map<String, dynamic> current = this;

    for (int i = 0; i < keys.length; i++) {
      String key = keys[i];
      if (i == keys.length - 1) {
        current[key] = value;
      } else {
        if (!current.containsKey(key) || current[key] is! Map<String, dynamic>) {
          current[key] = <String, dynamic>{};
        }
        current = current[key] as Map<String, dynamic>;
      }
    }
  }
}
