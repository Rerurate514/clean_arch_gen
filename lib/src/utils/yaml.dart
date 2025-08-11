import 'package:clean_arch_gen/src/utils/nested_map_access.dart';
import 'package:clean_arch_gen/src/utils/paths.dart';

extension type const Yaml(Map<String, String> value){}

extension YamlEx on Yaml {
  String? getNested(Paths paths) {
    return value.getNested(paths.path);
  }

  void setNested(String path, String value) {
    this.value.setNested(path, value);
  }
}
