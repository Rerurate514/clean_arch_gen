import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createModel(Response response){
  return """
import 'package:freezed_annotation/freezed_annotation.dart';

part '${response.name.toLowerSnakeCase()}_response.freezed.dart';
part '${response.name.toLowerSnakeCase()}_response.g.dart';

@freezed
sealed class ${response.name}Response with _\$${response.name}Response {
  const factory ${response.name}Response() = _${response.name}Response;

  factory ${response.name}Response.fromJson(Map<String, dynamic> json) =>
      _\$${response.name}ResponseFromJson(json);
}
""";
}
