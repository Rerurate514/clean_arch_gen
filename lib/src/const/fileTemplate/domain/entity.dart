import 'package:clean_arch_gen/src/models/domain/entity.dart';

String createEntity(Entity entity){
  return """
import 'package:freezed_annotation/freezed_annotation.dart';

part '${entity.name.toLowerCase()}.freezed.dart';
part '${entity.name.toLowerCase()}.g.dart';

@freezed
sealed class ${entity.name} with _\$${entity.name} {
  const factory ${entity.name}() = _${entity.name};

  factory ${entity.name}.fromJson(Map<String, dynamic> json) => _\$${entity.name}FromJson(json);
}

""";
}
