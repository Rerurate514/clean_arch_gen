import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createEntity(Entity entity) {
  final fields = entity.classFields
      .map((classField) => "required ${classField.type} ${classField.name},")
      .join('\n    ');

  return """
import 'package:freezed_annotation/freezed_annotation.dart';

part '${entity.name.toLowerCamelCase()}.freezed.dart';
part '${entity.name.toLowerCamelCase()}.g.dart';

@freezed
sealed class ${entity.name} with _\$${entity.name} {
  const factory ${entity.name}({
    $fields
  }) = _${entity.name};

  factory ${entity.name}.fromJson(Map<String, dynamic> json) => _\$${entity.name}FromJson(json);
}

""";
}
