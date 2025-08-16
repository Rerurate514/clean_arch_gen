import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_field.freezed.dart';
part 'class_field.g.dart';

@freezed
sealed class ClassField with _$ClassField {

  const factory ClassField({
    required String name,
    required String type
  }) = _ClassField;

  factory ClassField.fromJson(Map<String, dynamic> json) => _$ClassFieldFromJson(json);
}

