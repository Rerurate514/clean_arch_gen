import 'package:clean_arch_gen/src/models/utils/class_field.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity.freezed.dart';
part 'entity.g.dart';

@freezed
sealed class Entity with _$Entity {
  const factory Entity({
    required String name,
    required List<ClassField> classFields
  }) = _Entity;

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);
}
