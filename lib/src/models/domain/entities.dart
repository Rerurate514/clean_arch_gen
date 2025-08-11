import 'package:clean_arch_gen/src/models/utils/class_fields.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entities.freezed.dart';
part 'entities.g.dart';

@freezed
sealed class Entities with _$Entities {

  factory Entities({
    required List<ClassFields> classFields
  }) = _Entities;

  factory Entities.fromJson(Map<String, dynamic> json) => _$EntitiesFromJson(json);
}
