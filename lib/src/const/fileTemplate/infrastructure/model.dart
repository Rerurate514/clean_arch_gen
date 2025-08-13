import 'package:clean_arch_gen/src/models/infrastructure/response.dart';

String createModel(Response response){
  return """
import 'package:freezed_annotation/freezed_annotation.dart';

part '${response.name.toLowerCase()}.freezed.dart';
part '${response.name.toLowerCase()}.g.dart';

@freezed
sealed class ${response.name} with _\$${response.name} {
  const factory ${response.name}() = _${response.name};

  factory ${response.name}.fromJson(Map<String, dynamic> json) =>
      _\$${response.name}FromJson(json);
}
""";
}
