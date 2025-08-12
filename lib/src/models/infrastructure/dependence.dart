import 'package:freezed_annotation/freezed_annotation.dart';

part 'dependence.freezed.dart';
part 'dependence.g.dart';

@freezed
sealed class Dependence with _$Dependence {
  const factory Dependence({
    required String name
  }) = _Dependence;

  factory Dependence.fromJson(Map<String, dynamic> json) => _$DependenceFromJson(json);
}
