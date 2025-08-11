import 'package:clean_arch_gen/src/models/utils/class_field.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_fields.freezed.dart';
part 'class_fields.g.dart';

@freezed
sealed class ClassFields with _$ClassFields {

  const factory ClassFields({
    required List<ClassField> classField,
  }) = _ClassFields;

  factory ClassFields.fromJson(Map<String, dynamic> json) => _$ClassFieldsFromJson(json);
}

